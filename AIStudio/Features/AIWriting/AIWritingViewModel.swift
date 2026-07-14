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
    var translateOption = TextSelectionOption.languageSamples[2]
    var styleOption = TextSelectionOption.styleSamples[0]
    var expandedSetting: AIWritingExpandedSetting?

    let characterLimit = 400
    let translateOptions = TextSelectionOption.languageSamples
    let styleOptions = TextSelectionOption.styleSamples

    var isGenerateEnabled: Bool {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty && inputText.count <= characterLimit
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
        guard isGenerateEnabled else { return }
        // Stub until writing API is wired.
        resultText = inputText
    }
}
