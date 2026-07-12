//
//  ChatViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Foundation
import Observation
import UIKit

struct PendingChatAttachment: Identifiable, Equatable {
    let id: UUID
    let image: UIImage
    var existingFileName: String?

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.existingFileName == rhs.existingFileName
    }
}

enum ChatMediaAccessAlert: Equatable {
    case photoLibrary
    case camera
}

enum ChatImportSource: Equatable {
    case camera
    case gallery
    case files
}

@MainActor
@Observable
final class ChatViewModel {
    static let maxAttachments = 10

    let title = "AI Chat"

    var promptText = ""
    private(set) var messages: [ChatMessage] = []
    private(set) var subtitleDate: Date = .now
    private(set) var isGenerating = false
    private(set) var streamingAssistantID: UUID?
    private(set) var scrollPinUserMessageID: UUID?
    private(set) var scrollPinToken: UInt = 0

    private(set) var pendingAttachments: [PendingChatAttachment] = []
    private(set) var isAttachmentLoading = false
    private(set) var isPhotoPickerPresented = false
    private(set) var isCameraPickerPresented = false
    private(set) var isFileImporterPresented = false
    private(set) var mediaAccessAlert: ChatMediaAccessAlert?

    var subtitle: String {
        Self.dateFormatter.locale = LanguageStore.resolvedLocale
        return Self.dateFormatter.string(from: subtitleDate)
    }

    var showsEmptyState: Bool {
        messages.isEmpty
    }

    var composerPlaceholder: String {
        messages.isEmpty ? "Ask anything..." : "How can I help you?"
    }

    var composerMode: ComposerInputMode {
        if isAttachmentLoading || !pendingAttachments.isEmpty {
            .attachment(isLoading: isAttachmentLoading)
        } else {
            .text
        }
    }

    var remainingAttachmentSlots: Int {
        max(0, Self.maxAttachments - pendingAttachments.count)
    }

    private let sessionID: UUID
    private var chatID: String?
    private var editingUserMessageID: UUID?
    private var pendingImportSource: ChatImportSource?
    private var generationTask: Task<Void, Never>?
    private let chatService: any ChatServing
    private let repository: ChatHistoryRepository
    private let photoLibrary: PhotoLibraryAccessProviding
    private let cameraAccess: CameraAccessProviding

    private var revealPendingText = ""
    private var revealDisplayedText = ""
    private var revealAssistantID: UUID?
    private var revealStreamFinished = false
    private var revealTask: Task<Void, Never>?
    private var revealCompletionContinuation: CheckedContinuation<Void, Never>?

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    /// Block appearance (no typing): larger chunks + pause for fade.
    private static let revealTick: Duration = .milliseconds(420)
    private static let revealIdlePoll: Duration = .milliseconds(40)
    private static let revealMinCharactersPerBlock = 48
    private static let revealMaxCharactersPerBlock = 110

    init(
        sessionID: UUID? = nil,
        chatService: (any ChatServing)? = nil,
        repository: ChatHistoryRepository,
        photoLibrary: PhotoLibraryAccessProviding = PhotoLibraryAccessService(),
        cameraAccess: CameraAccessProviding = CameraAccessService()
    ) {
        self.chatService = chatService ?? GeminiChatService()
        self.repository = repository
        self.photoLibrary = photoLibrary
        self.cameraAccess = cameraAccess

        if let sessionID, let session = repository.session(id: sessionID) {
            self.sessionID = sessionID
            self.chatID = sessionID.uuidString.lowercased()
            self.messages = session.messages
            self.subtitleDate = session.updatedAt
        } else {
            self.sessionID = sessionID ?? UUID()
            self.chatID = self.sessionID.uuidString.lowercased()
        }
    }

    func sendTapped() {
        let trimmed = promptText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard (!trimmed.isEmpty || !pendingAttachments.isEmpty), !isGenerating else { return }

        let attachmentsSnapshot = pendingAttachments
        promptText = ""
        pendingAttachments = []

        if let editingID = editingUserMessageID {
            editingUserMessageID = nil
            resendEditedPrompt(id: editingID, text: trimmed, attachments: attachmentsSnapshot)
            return
        }

        let imageFileNames = persistAttachments(attachmentsSnapshot)
        let userID = UUID()
        let generatingID = UUID()
        let activeChatID = resolvedChatID()

        messages.append(.user(id: userID, text: trimmed, imageFileNames: imageFileNames))
        messages.append(.generating(id: generatingID))
        requestScrollPin(to: userID)

        startGeneration(
            chatID: activeChatID,
            history: makeHistory(),
            generatingID: generatingID
        )
    }

    func importSourceSelected(_ source: ChatImportSource) {
        guard remainingAttachmentSlots > 0, !isGenerating else { return }
        switch source {
        case .camera:
            beginCameraImport()
        case .gallery:
            beginGalleryImport()
        case .files:
            isFileImporterPresented = true
        }
    }

    func mediaAccessCancelled() {
        mediaAccessAlert = nil
        pendingImportSource = nil
    }

    func beginMediaAccessRequest() {
        guard let source = pendingImportSource else {
            mediaAccessAlert = nil
            return
        }

        Task {
            switch source {
            case .gallery:
                await resolveGalleryAccess()
            case .camera:
                await resolveCameraAccess()
            case .files:
                mediaAccessAlert = nil
                pendingImportSource = nil
            }
        }
    }

    func photoPickerDismissed() {
        isPhotoPickerPresented = false
    }

    func cameraPickerDismissed() {
        isCameraPickerPresented = false
    }

    func fileImporterDismissed() {
        isFileImporterPresented = false
    }

    func beginAttachmentLoading() {
        isAttachmentLoading = true
    }

    func finishAttachmentLoading() {
        isAttachmentLoading = false
    }

    func appendAttachments(_ images: [UIImage]) {
        let slots = remainingAttachmentSlots
        guard slots > 0 else {
            isAttachmentLoading = false
            return
        }

        let limited = images.prefix(slots).map {
            PendingChatAttachment(id: UUID(), image: $0, existingFileName: nil)
        }
        pendingAttachments.append(contentsOf: limited)
        isAttachmentLoading = false
    }

    func removeAttachment(_ id: UUID) {
        pendingAttachments.removeAll { $0.id == id }
    }

    func microTapped() {}

    func copyUserPromptTapped(_ messageID: UUID) {
        guard case let .user(_, text, _) = messages.first(where: { $0.id == messageID }) else {
            return
        }
        UIPasteboard.general.string = text
    }

    func editUserPromptTapped(_ messageID: UUID) {
        guard !isGenerating else { return }
        guard case let .user(_, text, imageFileNames) = messages.first(where: { $0.id == messageID })
        else {
            return
        }
        editingUserMessageID = messageID
        promptText = text
        pendingAttachments = imageFileNames.compactMap { fileName in
            guard
                let data = ChatImageStore.loadData(sessionID: sessionID, fileName: fileName),
                let image = UIImage(data: data)
            else {
                return nil
            }
            return PendingChatAttachment(
                id: UUID(),
                image: image,
                existingFileName: fileName
            )
        }
    }

    func images(for message: ChatMessage) -> [UIImage] {
        guard case let .user(_, _, imageFileNames) = message else { return [] }
        return imageFileNames.compactMap { fileName in
            guard let data = ChatImageStore.loadData(sessionID: sessionID, fileName: fileName) else {
                return nil
            }
            return UIImage(data: data)
        }
    }

    func copyResponseTapped(_ messageID: UUID) {
        guard case let .assistant(_, content) = messages.first(where: { $0.id == messageID }) else {
            return
        }
        UIPasteboard.general.string = plainText(from: content)
    }

    func refreshResponseTapped(_ messageID: UUID) {
        guard !isGenerating else { return }
        guard let assistantIndex = messages.firstIndex(where: { $0.id == messageID }),
              case .assistant = messages[assistantIndex],
              assistantIndex > 0,
              case let .user(userID, _, _) = messages[assistantIndex - 1]
        else {
            return
        }

        editingUserMessageID = nil

        messages.removeSubrange(assistantIndex...)

        let generatingID = UUID()
        let activeChatID = resolvedChatID()
        messages.append(.generating(id: generatingID))
        requestScrollPin(to: userID)

        startGeneration(
            chatID: activeChatID,
            history: makeHistory(),
            generatingID: generatingID
        )
    }

    private func beginGalleryImport() {
        if photoLibrary.currentStatus.isGranted {
            isPhotoPickerPresented = true
            return
        }
        pendingImportSource = .gallery
        mediaAccessAlert = .photoLibrary
    }

    private func beginCameraImport() {
        guard cameraAccess.isCameraAvailable else { return }

        if cameraAccess.currentStatus.isGranted {
            isCameraPickerPresented = true
            return
        }
        pendingImportSource = .camera
        mediaAccessAlert = .camera
    }

    private func resolveGalleryAccess() async {
        let currentStatus = photoLibrary.currentStatus

        switch currentStatus {
        case .notDetermined:
            let status = await photoLibrary.requestAccess()
            mediaAccessAlert = nil
            pendingImportSource = nil
            guard status.isGranted else { return }
            isPhotoPickerPresented = true

        case .denied, .restricted:
            mediaAccessAlert = nil
            pendingImportSource = nil
            photoLibrary.openSettings()

        case .authorized, .limited:
            mediaAccessAlert = nil
            pendingImportSource = nil
            isPhotoPickerPresented = true
        }
    }

    private func resolveCameraAccess() async {
        let currentStatus = cameraAccess.currentStatus

        switch currentStatus {
        case .notDetermined:
            let status = await cameraAccess.requestAccess()
            mediaAccessAlert = nil
            pendingImportSource = nil
            guard status.isGranted else { return }
            isCameraPickerPresented = true

        case .denied, .restricted:
            mediaAccessAlert = nil
            pendingImportSource = nil
            cameraAccess.openSettings()

        case .authorized:
            mediaAccessAlert = nil
            pendingImportSource = nil
            isCameraPickerPresented = true
        }
    }

    private func persistAttachments(_ attachments: [PendingChatAttachment]) -> [String] {
        attachments.compactMap { attachment in
            if let existing = attachment.existingFileName {
                return existing
            }
            guard let data = ChatImageEncoder.jpegData(from: attachment.image) else { return nil }
            return try? ChatImageStore.saveJPEG(sessionID: sessionID, data: data)
        }
    }

    private func resendEditedPrompt(
        id: UUID,
        text: String,
        attachments: [PendingChatAttachment]
    ) {
        guard let index = messages.firstIndex(where: { $0.id == id }),
              case let .user(_, _, oldFileNames) = messages[index]
        else {
            return
        }

        let imageFileNames = persistAttachments(attachments)
        let removed = Set(oldFileNames).subtracting(imageFileNames)
        ChatImageStore.delete(sessionID: sessionID, fileNames: Array(removed))

        messages[index] = .user(id: id, text: text, imageFileNames: imageFileNames)
        if index + 1 < messages.count {
            messages.removeSubrange((index + 1)...)
        }

        let generatingID = UUID()
        let activeChatID = resolvedChatID()
        messages.append(.generating(id: generatingID))
        requestScrollPin(to: id)

        startGeneration(
            chatID: activeChatID,
            history: makeHistory(),
            generatingID: generatingID
        )
    }

    private func requestScrollPin(to userMessageID: UUID) {
        scrollPinUserMessageID = userMessageID
        scrollPinToken &+= 1
    }

    private func resolvedChatID() -> String {
        if let chatID {
            return chatID
        }
        let newID = sessionID.uuidString.lowercased()
        chatID = newID
        return newID
    }

    private func startGeneration(
        chatID: String,
        history: [ChatHistoryMessage],
        generatingID: UUID
    ) {
        generationTask?.cancel()
        resetRevealState()
        isGenerating = true
        generationTask = Task { [weak self] in
            await self?.generateReply(
                chatID: chatID,
                history: history,
                generatingID: generatingID
            )
        }
    }

    private func generateReply(
        chatID: String,
        history: [ChatHistoryMessage],
        generatingID: UUID
    ) async {
        defer {
            isGenerating = false
            generationTask = nil
        }

        var assembled = ""
        var didShowAssistant = false

        do {
            for try await delta in chatService.streamMessage(chatID: chatID, history: history) {
                guard !Task.isCancelled else { return }

                assembled += delta

                if !didShowAssistant {
                    didShowAssistant = true
                    replaceGeneratingWithAssistant(generatingID: generatingID, text: "")
                    beginReveal(assistantID: generatingID)
                }

                enqueueReveal(delta)
            }

            guard !Task.isCancelled else { return }

            if assembled.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                failGeneration(
                    generatingID: generatingID,
                    message: APIError.emptyResponse.localizedDescription
                )
            } else {
                await finishRevealAndPersist()
            }
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch {
            guard !Task.isCancelled else { return }

            if assembled.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                failGeneration(
                    generatingID: generatingID,
                    message: userFacingMessage(for: error)
                )
            } else {
                await finishRevealAndPersist()
            }
        }
    }

    private func beginReveal(assistantID: UUID) {
        revealAssistantID = assistantID
        streamingAssistantID = assistantID
        revealPendingText = ""
        revealDisplayedText = ""
        revealStreamFinished = false
        startRevealLoopIfNeeded()
    }

    private func enqueueReveal(_ delta: String) {
        revealPendingText += delta
        startRevealLoopIfNeeded()
    }

    private func finishRevealAndPersist() async {
        revealStreamFinished = true
        await waitForRevealCatchUp()

        if let assistantID = revealAssistantID {
            revealDisplayedText = revealPendingText
            updateAssistant(id: assistantID, text: revealPendingText)
        }
        persist()
        resetRevealState()
    }

    private func waitForRevealCatchUp() async {
        if revealDisplayedText.count >= revealPendingText.count {
            return
        }

        startRevealLoopIfNeeded()

        await withCheckedContinuation { continuation in
            if revealDisplayedText.count >= revealPendingText.count {
                continuation.resume()
                return
            }

            revealCompletionContinuation = continuation

            // Loop may have finished between the check and storing the continuation.
            if revealTask == nil, revealDisplayedText.count >= revealPendingText.count {
                revealCompletionContinuation = nil
                continuation.resume()
            }
        }
    }

    private func startRevealLoopIfNeeded() {
        guard revealTask == nil else { return }

        revealTask = Task { [weak self] in
            await self?.runRevealLoop()
        }
    }

    private func runRevealLoop() async {
        defer {
            revealTask = nil
            resumeRevealCompletionIfNeeded()
        }

        while !Task.isCancelled {
            let pending = revealPendingText
            let displayed = revealDisplayedText

            if displayed.count >= pending.count {
                if revealStreamFinished {
                    return
                }
                try? await Task.sleep(for: Self.revealIdlePoll)
                continue
            }

            guard let assistantID = revealAssistantID else { return }

            guard let next = Self.nextRevealText(
                displayed: displayed,
                full: pending,
                streamFinished: revealStreamFinished
            ) else {
                if revealStreamFinished {
                    return
                }
                try? await Task.sleep(for: Self.revealIdlePoll)
                continue
            }

            revealDisplayedText = next
            updateAssistant(id: assistantID, text: next)

            if next.count >= pending.count, revealStreamFinished {
                return
            }

            try? await Task.sleep(for: Self.revealTick)
        }
    }

    private func resumeRevealCompletionIfNeeded() {
        guard revealStreamFinished,
              revealDisplayedText.count >= revealPendingText.count,
              let continuation = revealCompletionContinuation
        else { return }

        revealCompletionContinuation = nil
        continuation.resume()
    }

    private func resetRevealState() {
        revealTask?.cancel()
        revealTask = nil
        revealPendingText = ""
        revealDisplayedText = ""
        revealAssistantID = nil
        streamingAssistantID = nil
        revealStreamFinished = false
        if let continuation = revealCompletionContinuation {
            revealCompletionContinuation = nil
            continuation.resume()
        }
    }

    /// Reveals sentence/clause-sized blocks only — never character typing.
    /// Returns `nil` when we should wait for more buffered text.
    private static func nextRevealText(
        displayed: String,
        full: String,
        streamFinished: Bool
    ) -> String? {
        guard displayed.count < full.count else { return full }

        let start = full.index(full.startIndex, offsetBy: displayed.count)
        let remaining = full[start...]

        if streamFinished {
            return full
        }

        if let sentenceEnd = firstSentenceEnd(in: remaining),
           full.distance(from: start, to: sentenceEnd) >= 1
        {
            return String(full[..<sentenceEnd])
        }

        let buffered = remaining.count
        let minimum = displayed.isEmpty ? 24 : revealMinCharactersPerBlock
        guard buffered >= minimum else {
            return nil
        }

        let hardLimit = min(buffered, revealMaxCharactersPerBlock)
        var index = full.index(start, offsetBy: hardLimit)

        // Prefer breaking on whitespace so blocks look natural.
        if index < full.endIndex, !full[index].isWhitespace {
            if let space = full[..<index].lastIndex(where: \.isWhitespace),
               space > start
            {
                index = full.index(after: space)
            }
        } else if index < full.endIndex, full[index].isWhitespace {
            while index < full.endIndex, full[index].isWhitespace {
                index = full.index(after: index)
            }
        }

        guard index > start else { return nil }
        return String(full[..<index])
    }

    private static func firstSentenceEnd(in text: Substring) -> String.Index? {
        var index = text.startIndex
        var seenContent = false

        while index < text.endIndex {
            let character = text[index]
            if !character.isWhitespace {
                seenContent = true
            }

            if seenContent, isSentenceTerminator(character) {
                var end = text.index(after: index)
                while end < text.endIndex, isSentenceTerminator(text[end]) {
                    end = text.index(after: end)
                }
                while end < text.endIndex, text[end].isWhitespace {
                    end = text.index(after: end)
                    break
                }
                return end
            }

            if character == "\n" {
                let end = text.index(after: index)
                if seenContent {
                    return end
                }
            }

            index = text.index(after: index)
        }

        return nil
    }

    private static func isSentenceTerminator(_ character: Character) -> Bool {
        character == "." || character == "!" || character == "?" || character == "…"
    }

    private func replaceGeneratingWithAssistant(generatingID: UUID, text: String) {
        messages.removeAll {
            if case let .generating(id) = $0 { id == generatingID } else { false }
        }
        messages.append(
            .assistant(
                id: generatingID,
                content: AIResponseContent(
                    title: "",
                    paragraphs: [text],
                    bullets: []
                )
            )
        )
    }

    private func updateAssistant(id: UUID, text: String) {
        guard let index = messages.firstIndex(where: { $0.id == id }) else { return }
        messages[index] = .assistant(
            id: id,
            content: AIResponseContent(
                title: "",
                paragraphs: [text],
                bullets: []
            )
        )
    }

    private func makeHistory() -> [ChatHistoryMessage] {
        messages.compactMap { message -> ChatHistoryMessage? in
            switch message {
            case let .user(_, text, imageFileNames):
                let images = imageFileNames.compactMap { fileName -> ChatInlineImage? in
                    guard let data = ChatImageStore.loadData(sessionID: sessionID, fileName: fileName)
                    else {
                        return nil
                    }
                    return ChatInlineImage(mimeType: ChatImageEncoder.mimeType, data: data)
                }
                let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                return ChatHistoryMessage(
                    role: .user,
                    text: trimmed.isEmpty ? nil : trimmed,
                    images: images
                )
            case let .assistant(_, content):
                return ChatHistoryMessage(role: .model, text: plainText(from: content))
            case .generating, .error:
                return nil
            }
        }
    }

    private func plainText(from content: AIResponseContent) -> String {
        var parts: [String] = []
        if !content.title.isEmpty {
            parts.append(content.title)
        }
        parts.append(contentsOf: content.paragraphs)
        for bullet in content.bullets {
            parts.append("• \(bullet.emphasis) \(bullet.text)")
        }
        parts.append(contentsOf: content.closingParagraphs)
        return parts.joined(separator: "\n\n")
    }

    private func userFacingMessage(for error: Error) -> String {
        if let apiError = error as? APIError {
            return apiError.localizedDescription
        }
        if error is URLError {
            return APIError.network.localizedDescription
        }
        return L10n.string("Something went wrong. Please try again.")
    }

    private func failGeneration(generatingID: UUID, message: String) {
        resetRevealState()
        messages.removeAll {
            if case let .generating(id) = $0 { id == generatingID } else { false }
        }
        messages.removeAll { $0.id == generatingID }
        messages.append(.error(text: message))
        persist()
    }

    private func persist() {
        let fallbackTitle = messages.lazy.compactMap { message -> String? in
            if case let .user(_, text, imageFileNames) = message {
                let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                if !trimmed.isEmpty { return trimmed }
                if !imageFileNames.isEmpty { return L10n.string("Photo") }
            }
            return nil
        }.first ?? L10n.string("New Chat")

        repository.upsert(
            id: sessionID,
            fallbackTitle: fallbackTitle,
            messages: messages
        )
        subtitleDate = .now
    }
}
