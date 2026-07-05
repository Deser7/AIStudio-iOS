//
//  ChatViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Combine
import Foundation

final class ChatViewModel: ObservableObject {
    let title = "AI Chat"

    @Published var promptText = ""
    @Published private(set) var messages: [ChatMessage] = []

    var subtitle: String {
        Self.dateFormatter.string(from: Date())
    }

    var showsEmptyState: Bool {
        messages.isEmpty
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    func sendTapped() {
        let trimmed = promptText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        messages.append(ChatMessage(text: trimmed, isUser: true))
        promptText = ""
    }

    func regenerateTapped() {}

    func importTapped() {}

    func microTapped() {}
}
