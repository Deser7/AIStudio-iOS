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

    var composerPlaceholder: String {
        messages.isEmpty ? "Ask anything..." : "How can I help you?"
    }

    var isGenerating: Bool {
        messages.contains {
            if case .generating = $0 { true } else { false }
        }
    }

    private var generationTask: Task<Void, Never>?

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    private static let generationDelay: Duration = .seconds(2)

    deinit {
        generationTask?.cancel()
    }

    func sendTapped() {
        let trimmed = promptText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !isGenerating else { return }

        promptText = ""

        let generatingID = UUID()
        messages.append(.user(text: trimmed))
        messages.append(.generating(id: generatingID))

        generationTask?.cancel()
        generationTask = Task { @MainActor [weak self] in
            try? await Task.sleep(for: Self.generationDelay)
            guard !Task.isCancelled else { return }
            self?.completeGeneration(generatingID: generatingID)
        }
    }

    func regenerateTapped() {}

    func importTapped() {}

    func microTapped() {}

    func copyResponseTapped() {}

    func refreshResponseTapped() {}

    @MainActor
    private func completeGeneration(generatingID: UUID) {
        messages.removeAll {
            if case let .generating(id) = $0 { id == generatingID } else { false }
        }
        messages.append(.assistant(content: ChatStub.welcomeEmail))
    }
}
