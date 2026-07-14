//
//  ChatViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Foundation
import Observation

struct PendingChatAttachment: Identifiable, Equatable, Sendable {
    let id: UUID
    let imageData: Data
    var existingFileName: String?

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.existingFileName == rhs.existingFileName
    }
}

enum ChatMediaAccessAlert: Equatable {
    case photoLibrary
}

enum ChatImportSource: Equatable {
    case gallery
    case files
}

@MainActor
@Observable
final class ChatViewModel {
    static let maxAttachments = 10

    let title = "AI Chat"

    var promptText = ""
    var messages: [ChatMessage] = []
    var subtitleDate: Date = .now
    var isGenerating = false
    var streamingAssistantID: UUID?
    var scrollPinUserMessageID: UUID?
    var scrollPinToken: UInt = 0

    var pendingAttachments: [PendingChatAttachment] = []
    var isAttachmentLoading = false
    var isPhotoPickerPresented = false
    var openSettingsEvent: UUID?
    var isFileImporterPresented = false
    var mediaAccessAlert: ChatMediaAccessAlert?

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

    let sessionID: UUID
    var chatID: String?
    var editingUserMessageID: UUID?
    var pendingImportSource: ChatImportSource?
    var generationTask: Task<Void, Never>?
    let chatService: any ChatServing
    let repository: ChatHistoryRepository
    let photoLibrary: PhotoLibraryAccessProviding

    var revealPendingText = ""
    var revealDisplayedText = ""
    var revealAssistantID: UUID?
    var revealStreamFinished = false
    var revealTask: Task<Void, Never>?
    var revealCompletionContinuation: CheckedContinuation<Void, Never>?

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    init(
        sessionID: UUID? = nil,
        chatService: (any ChatServing)? = nil,
        repository: ChatHistoryRepository,
        photoLibrary: PhotoLibraryAccessProviding = PhotoLibraryAccessService()
    ) {
        self.chatService = chatService ?? GeminiChatService()
        self.repository = repository
        self.photoLibrary = photoLibrary

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

    func requestScrollPin(to userMessageID: UUID) {
        scrollPinUserMessageID = userMessageID
        scrollPinToken &+= 1
    }

    func resolvedChatID() -> String {
        if let chatID {
            return chatID
        }
        let newID = sessionID.uuidString.lowercased()
        chatID = newID
        return newID
    }
}
