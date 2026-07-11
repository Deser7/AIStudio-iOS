//
//  ChatViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Foundation
import Observation

@Observable
final class ChatViewModel {
    let title = "AI Chat"

    var promptText = ""
    private(set) var messages: [ChatMessage] = []

    var subtitle: String {
        Self.dateFormatter.string(from: Date())
    }

    var showsEmptyState: Bool {
        messages.isEmpty
    }

    var composerPlaceholder: String {
        messages.isEmpty ? "Ask anything..." : "How can I help you?"
    }

    var isGenerating: Bool {
        messages.contains {
            if case .generating = $0 { true } else { false }
        }
    }

    private var chatID: String?
    private var generationTask: Task<Void, Never>?
    private let chatService: any ChatServing

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    init(chatService: any ChatServing = GeminiChatService()) {
        self.chatService = chatService
    }

    deinit {
        generationTask?.cancel()
    }

    func sendTapped() {
        let trimmed = promptText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !isGenerating else { return }

        promptText = ""

        let generatingID = UUID()
        let activeChatID = chatID ?? UUID().uuidString.lowercased()
        if chatID == nil {
            chatID = activeChatID
        }

        messages.append(.user(text: trimmed))
        messages.append(.generating(id: generatingID))

        let history = makeHistory()

        generationTask?.cancel()
        generationTask = Task { [weak self] in
            await self?.generateReply(
                chatID: activeChatID,
                history: history,
                generatingID: generatingID
            )
        }
    }

    func importTapped() {}

    func microTapped() {}

    func copyResponseTapped() {}

    func refreshResponseTapped() {}

    private func generateReply(
        chatID: String,
        history: [ChatHistoryMessage],
        generatingID: UUID
    ) async {
        do {
            let result = try await chatService.sendMessage(
                chatID: chatID,
                history: history
            )
            guard !Task.isCancelled else { return }
            self.chatID = result.chatID
            completeGeneration(
                generatingID: generatingID,
                content: AIResponseContent(
                    title: "",
                    paragraphs: [result.assistantMessage],
                    bullets: []
                )
            )
        } catch {
            guard !Task.isCancelled else { return }
            failGeneration(
                generatingID: generatingID,
                message: userFacingMessage(for: error)
            )
        }
    }

    private func makeHistory() -> [ChatHistoryMessage] {
        messages.compactMap { message in
            switch message {
            case let .user(_, text):
                ChatHistoryMessage(role: .user, text: text)
            case let .assistant(_, content):
                ChatHistoryMessage(role: .model, text: plainText(from: content))
            case .generating, .error:
                nil
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
        return "Something went wrong. Please try again."
    }

    private func completeGeneration(generatingID: UUID, content: AIResponseContent) {
        messages.removeAll {
            if case let .generating(id) = $0 { id == generatingID } else { false }
        }
        messages.append(.assistant(content: content))
    }

    private func failGeneration(generatingID: UUID, message: String) {
        messages.removeAll {
            if case let .generating(id) = $0 { id == generatingID } else { false }
        }
        messages.append(.error(text: message))
    }
}
