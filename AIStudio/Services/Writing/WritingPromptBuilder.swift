//
//  WritingPromptBuilder.swift
//  AIStudio
//

import Foundation

enum WritingPromptBuilder {
    static func systemInstruction(
        action: WritingAction,
        style: TextSelectionOption,
        translate: TextSelectionOption
    ) -> String {
        """
        You are a professional writing assistant.
        Task: \(action.systemPrompt)
        Style: \(style.stylePromptValue)
        Translation: \(translate.translatePromptValue)
        Rules:
        - Return only the final rewritten text
        - Do not add explanations, markdown, or quotes
        - Preserve meaning unless the task asks to shorten
        """
    }
}

extension WritingAction {
    var systemPrompt: String {
        switch self {
        case .improve:
            "Improve clarity, flow, and word choice while keeping the original meaning."
        case .rewrite:
            "Rewrite the text while preserving the core meaning."
        case .fixGrammar:
            "Fix grammar, spelling, and punctuation. Make minimal stylistic changes."
        case .shorten:
            "Shorten the text while keeping all key information."
        }
    }
}

extension TextSelectionOption {
    var translatePromptValue: String {
        switch title {
        case "Original":
            "Do not translate. Keep the original language."
        case "English":
            "Translate the result to English."
        case "Spanish":
            "Translate the result to Spanish."
        case "German":
            "Translate the result to German."
        case "Italian":
            "Translate the result to Italian."
        case "French":
            "Translate the result to French."
        default:
            title
        }
    }

    var stylePromptValue: String {
        switch title {
        case "Original":
            "Keep the original tone."
        case "Professional":
            "Use a professional tone."
        case "Casual":
            "Use a casual tone."
        case "Friendly":
            "Use a friendly tone."
        default:
            title
        }
    }
}
