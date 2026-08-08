//
//  SummaryViewModel.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 07.08.2026.
//

import Foundation
import Observation
import PDFKit
import UniformTypeIdentifiers

enum SummaryLoadState: Equatable {
    case idle
    case loading
    case loaded
    case error(String)
}

enum UnderstandFileKind: Equatable, Sendable {
    case pdf
    case plainText
    case rtf
    case word
    case image
    case audio
    case other
}

struct UnderstandImportedFile: Identifiable, Equatable, Sendable {
    let id: UUID
    let fileName: String
    let mimeType: String
    let data: Data
    let kind: UnderstandFileKind
    let pageCount: Int?
    let extractedText: String?

    init(
        id: UUID = UUID(),
        fileName: String,
        mimeType: String,
        data: Data,
        kind: UnderstandFileKind,
        pageCount: Int? = nil,
        extractedText: String? = nil
    ) {
        self.id = id
        self.fileName = fileName
        self.mimeType = mimeType
        self.data = data
        self.kind = kind
        self.pageCount = pageCount
        self.extractedText = extractedText
    }
}

@MainActor
enum UnderstandFasterSession {
    static var pendingFiles: [UnderstandImportedFile] = []

    static func enqueue(_ files: [UnderstandImportedFile]) {
        pendingFiles = files
    }

    static func consumePendingFiles() -> [UnderstandImportedFile] {
        let files = pendingFiles
        pendingFiles = []
        return files
    }
}

enum UnderstandFileImportSupport {
    static let maxFileCount = 10
    static let maxFileSizeBytes = 50 * 1024 * 1024

    static var allowedContentTypes: [UTType] {
        var types: [UTType] = [.pdf, .plainText, .rtf, .image, .audio]
        if let doc = UTType(filenameExtension: "doc") {
            types.append(doc)
        }
        if let docx = UTType(filenameExtension: "docx") {
            types.append(docx)
        }
        return types
    }

    enum ImportError: Error, Equatable {
        case cancelled
        case empty
        case tooManyFiles
        case fileTooLarge(fileName: String)
        case unsupported
        case readFailed

        var messageKey: String {
            switch self {
            case .cancelled:
                ""
            case .empty:
                "Select at least one file."
            case .tooManyFiles:
                "You can select up to 10 files."
            case .fileTooLarge:
                "Each file must be 50 MB or smaller."
            case .unsupported:
                "Unsupported file type."
            case .readFailed:
                "Couldn't read the selected files."
            }
        }
    }

    static func load(from result: Result<[URL], Error>) -> Result<[UnderstandImportedFile], ImportError> {
        switch result {
        case .failure:
            return .failure(.cancelled)
        case let .success(urls):
            let fileURLs = urls.filter { !$0.hasDirectoryPath }
            guard !fileURLs.isEmpty else { return .failure(.empty) }
            guard fileURLs.count <= maxFileCount else { return .failure(.tooManyFiles) }

            var files: [UnderstandImportedFile] = []
            files.reserveCapacity(fileURLs.count)

            for url in fileURLs {
                let accessed = url.startAccessingSecurityScopedResource()
                defer {
                    if accessed {
                        url.stopAccessingSecurityScopedResource()
                    }
                }

                guard let data = try? Data(contentsOf: url) else {
                    return .failure(.readFailed)
                }
                guard data.count <= maxFileSizeBytes else {
                    return .failure(.fileTooLarge(fileName: url.lastPathComponent))
                }

                guard let file = makeFile(url: url, data: data) else {
                    return .failure(.unsupported)
                }
                files.append(file)
            }

            return .success(files)
        }
    }

    static func makeFile(url: URL, data: Data) -> UnderstandImportedFile? {
        let fileName = url.lastPathComponent
        let ext = url.pathExtension.lowercased()
        let kind = kind(forExtension: ext, utType: UTType(filenameExtension: ext))
        guard kind != .other || isSupportedExtension(ext) else { return nil }

        let mime = mimeType(forExtension: ext, fallbackType: UTType(filenameExtension: ext))
        let pages = kind == .pdf ? PDFDocument(data: data)?.pageCount : nil
        let text: String? = switch kind {
        case .plainText:
            String(data: data, encoding: .utf8)
                ?? String(data: data, encoding: .isoLatin1)
        case .rtf:
            rtfPlainText(from: data)
        default:
            nil
        }

        return UnderstandImportedFile(
            fileName: fileName,
            mimeType: mime,
            data: data,
            kind: kind,
            pageCount: pages,
            extractedText: text
        )
    }

    static func beforeTitle(for files: [UnderstandImportedFile]) -> String {
        guard !files.isEmpty else { return L10n.string("Document") }

        if files.count == 1, let file = files.first {
            switch file.kind {
            case .pdf:
                if let pages = file.pageCount, pages > 0 {
                    return String(format: L10n.string("%d-page document"), pages)
                }
                return file.fileName
            case .image:
                return L10n.string("1 Image")
            case .audio:
                return L10n.string("1 Audio")
            case .plainText, .rtf, .word, .other:
                return file.fileName
            }
        }

        if files.allSatisfy({ $0.kind == .image }) {
            return String(format: L10n.string("%d Images"), files.count)
        }
        if files.allSatisfy({ $0.kind == .audio }) {
            return String(format: L10n.string("%d Audio"), files.count)
        }
        if files.allSatisfy({ $0.kind == .pdf }) {
            let pages = files.compactMap(\.pageCount).reduce(0, +)
            if pages > 0 {
                return String(format: L10n.string("%d-page document"), pages)
            }
        }

        return String(format: L10n.string("%d Files"), files.count)
    }

    private static func isSupportedExtension(_ ext: String) -> Bool {
        [
            "pdf", "txt", "rtf", "doc", "docx",
            "png", "jpg", "jpeg", "heic", "heif", "webp", "gif",
            "mp3", "m4a", "aac", "wav", "caf", "flac", "ogg",
        ].contains(ext)
    }

    private static func kind(forExtension ext: String, utType: UTType?) -> UnderstandFileKind {
        switch ext {
        case "pdf":
            return .pdf
        case "txt":
            return .plainText
        case "rtf":
            return .rtf
        case "doc", "docx":
            return .word
        default:
            if utType?.conforms(to: .image) == true { return .image }
            if utType?.conforms(to: .audio) == true { return .audio }
            if utType?.conforms(to: .pdf) == true { return .pdf }
            if utType?.conforms(to: .plainText) == true { return .plainText }
            if utType?.conforms(to: .rtf) == true { return .rtf }
            return .other
        }
    }

    private static func mimeType(forExtension ext: String, fallbackType: UTType?) -> String {
        switch ext {
        case "pdf":
            return "application/pdf"
        case "txt":
            return "text/plain"
        case "rtf":
            return "text/rtf"
        case "doc":
            return "application/msword"
        case "docx":
            return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        case "png":
            return "image/png"
        case "jpg", "jpeg":
            return "image/jpeg"
        case "heic":
            return "image/heic"
        case "heif":
            return "image/heif"
        case "webp":
            return "image/webp"
        case "gif":
            return "image/gif"
        case "mp3":
            return "audio/mpeg"
        case "m4a", "aac":
            return "audio/mp4"
        case "wav":
            return "audio/wav"
        case "caf":
            return "audio/x-caf"
        case "flac":
            return "audio/flac"
        case "ogg":
            return "audio/ogg"
        default:
            return fallbackType?.preferredMIMEType ?? "application/octet-stream"
        }
    }

    private static func rtfPlainText(from data: Data) -> String? {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.rtf
        ]
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil).string
    }
}

enum UnderstandPromptBuilder {
    static var systemInstruction: String {
        """
        You are an assistant that helps users understand documents faster.
        Extract the most important key points from the provided files.
        Rules:
        - Return ONLY a JSON array of strings
        - Each string is one concise key point
        - Use the same language as the source content
        - No markdown, no code fences, no commentary
        Example: ["First point","Second point","Third point"]
        """
    }

    static func userPrompt(for files: [UnderstandImportedFile]) -> String {
        let names = files.map(\.fileName).joined(separator: ", ")
        return """
        Analyze the attached content and list key points.
        Files: \(names)
        """
    }
}

@Observable
final class SummaryViewModel {
    private(set) var files: [UnderstandImportedFile]
    private(set) var state: SummaryLoadState = .idle
    private(set) var keyPoints: [String] = []
    private(set) var beforeTitle = ""

    private let chatService: any ChatServing
    private var generationTask: Task<Void, Never>?
    private let minimumLoadingDuration: TimeInterval = 0.5

    var isRegenerateEnabled: Bool {
        !files.isEmpty && state != .loading
    }

    init(
        files: [UnderstandImportedFile],
        chatService: (any ChatServing)? = nil
    ) {
        self.files = files
        self.chatService = chatService ?? FailoverChatService.live
        beforeTitle = UnderstandFileImportSupport.beforeTitle(for: files)
    }

    func startIfNeeded() {
        guard state == .idle else { return }
        guard !files.isEmpty else {
            state = .error(L10n.string("Select at least one file."))
            return
        }
        analyze()
    }

    func regenerateTapped() {
        guard isRegenerateEnabled else { return }
        analyze()
    }

    private func analyze() {
        generationTask?.cancel()
        keyPoints = []
        state = .loading

        let history = makeHistory()
        let instruction = UnderstandPromptBuilder.systemInstruction

        generationTask = Task { [weak self] in
            await self?.runAnalysis(history: history, systemInstruction: instruction)
        }
    }

    private func runAnalysis(
        history: [ChatHistoryMessage],
        systemInstruction: String
    ) async {
        let startedAt = Date()
        var assembled = ""

        defer {
            generationTask = nil
        }

        do {
            for try await delta in chatService.streamMessage(
                chatID: UUID().uuidString,
                history: history,
                systemInstruction: systemInstruction
            ) {
                guard !Task.isCancelled else { return }
                assembled += delta
            }

            guard !Task.isCancelled else { return }

            await ensureMinimumLoading(from: startedAt)

            let points = Self.parseKeyPoints(from: assembled)
            if points.isEmpty {
                state = .error(APIError.emptyResponse.localizedDescription)
            } else {
                keyPoints = points
                state = .loaded
            }
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch {
            guard !Task.isCancelled else { return }
            await ensureMinimumLoading(from: startedAt)
            state = .error(userFacingMessage(for: error))
        }
    }

    private func makeHistory() -> [ChatHistoryMessage] {
        var textBlocks: [String] = [UnderstandPromptBuilder.userPrompt(for: files)]
        var binaries: [ChatInlineImage] = []

        for file in files {
            if let extracted = file.extractedText?
                .trimmingCharacters(in: .whitespacesAndNewlines),
                !extracted.isEmpty
            {
                textBlocks.append("File: \(file.fileName)\n\(extracted)")
            } else {
                binaries.append(ChatInlineImage(mimeType: file.mimeType, data: file.data))
                textBlocks.append("Attached file: \(file.fileName)")
            }
        }

        return [
            ChatHistoryMessage(
                role: .user,
                text: textBlocks.joined(separator: "\n\n"),
                images: binaries
            )
        ]
    }

    private func ensureMinimumLoading(from startedAt: Date) async {
        let elapsed = Date().timeIntervalSince(startedAt)
        let remaining = minimumLoadingDuration - elapsed
        guard remaining > 0 else { return }
        try? await Task.sleep(nanoseconds: UInt64(remaining * 1_000_000_000))
    }

    private func userFacingMessage(for error: Error) -> String {
        if let apiError = error as? APIError {
            return apiError.localizedDescription
        }
        if error is URLError {
            return APIError.network.localizedDescription
        }
        return APIError.invalidResponse.localizedDescription
    }

    nonisolated static func parseKeyPoints(from text: String) -> [String] {
        var payload = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if payload.hasPrefix("```") {
            let lines = payload.split(separator: "\n", omittingEmptySubsequences: false)
            payload = lines.dropFirst().joined(separator: "\n")
            if let fence = payload.range(of: "```") {
                payload = String(payload[..<fence.lowerBound])
            }
            payload = payload.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        if let data = payload.data(using: .utf8),
           let array = try? JSONDecoder().decode([String].self, from: data)
        {
            return array
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
        }

        return payload
            .components(separatedBy: .newlines)
            .map(sanitizeBulletLine)
            .filter { !$0.isEmpty }
    }

    nonisolated private static func sanitizeBulletLine(_ line: String) -> String {
        var value = line.trimmingCharacters(in: .whitespacesAndNewlines)
        for prefix in ["- ", "• ", "* ", "– ", "— "] {
            if value.hasPrefix(prefix) {
                value = String(value.dropFirst(prefix.count))
            }
        }
        if let regex = try? NSRegularExpression(pattern: #"^\d+[\.\)]\s+"#),
           let match = regex.firstMatch(
            in: value,
            range: NSRange(value.startIndex..., in: value)
           ),
           let range = Range(match.range, in: value)
        {
            value = String(value[range.upperBound...])
        }
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
