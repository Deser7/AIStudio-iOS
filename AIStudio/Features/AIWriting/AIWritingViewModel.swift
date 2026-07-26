//
//  AIWritingViewModel.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 13.07.2026.
//

import Foundation
import Observation

enum AIWritingExpandedSetting: Equatable {
    case translate
    case style
}

@Observable
final class AIWritingViewModel {
    var inputText = ""
    var resultText = ""
    var selectedAction: WritingAction = .fixGrammar
    var translateOption = TextSelectionOption.languageSamples[0]
    var styleOption = TextSelectionOption.styleSamples[0]
    var expandedSetting: AIWritingExpandedSetting?
    private(set) var isGenerating = false

    let characterLimit = 400
    let translateOptions = TextSelectionOption.languageSamples
    let styleOptions = TextSelectionOption.styleSamples

    private let chatService: any ChatServing
    private var generationTask: Task<Void, Never>?

    var isGenerateEnabled: Bool {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty && inputText.count <= characterLimit && !isGenerating
    }

    init(chatService: (any ChatServing)? = nil) {
        self.chatService = chatService ?? FailoverChatService.live
    }

    func selectAction(_ action: WritingAction) {
        selectedAction = action
    }

    func toggleSetting(_ setting: AIWritingExpandedSetting) {
        expandedSetting = expandedSetting == setting ? nil : setting
    }

    func selectTranslate(_ option: TextSelectionOption) {
        translateOption = option
        expandedSetting = nil
    }

    func selectStyle(_ option: TextSelectionOption) {
        styleOption = option
        expandedSetting = nil
    }

    func generateTapped() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, inputText.count <= characterLimit else { return }

        generationTask?.cancel()
        resultText = ""
        isGenerating = true

        let history = [ChatHistoryMessage(role: .user, text: trimmed)]
        let instruction = WritingPromptBuilder.systemInstruction(
            action: selectedAction,
            style: styleOption,
            translate: translateOption
        )

        generationTask = Task { [weak self] in
            await self?.generate(
                history: history,
                systemInstruction: instruction
            )
        }
    }

    private func generate(
        history: [ChatHistoryMessage],
        systemInstruction: String
    ) async {
        defer {
            isGenerating = false
            generationTask = nil
        }

        var assembled = ""

        do {
            for try await delta in chatService.streamMessage(
                chatID: UUID().uuidString,
                history: history,
                systemInstruction: systemInstruction
            ) {
                guard !Task.isCancelled else { return }
                assembled += delta
                resultText = assembled
            }

            guard !Task.isCancelled else { return }

            if assembled.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                resultText = APIError.emptyResponse.localizedDescription
            }
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch {
            guard !Task.isCancelled else { return }
            if assembled.isEmpty {
                resultText = userFacingMessage(for: error)
            }
        }
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
}
