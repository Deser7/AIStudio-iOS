//
//  TextSelectionOption.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import Foundation

struct TextSelectionOption: Identifiable, Hashable, Sendable {
    let title: String
    var id: String { title }

    static let languageSamples: [TextSelectionOption] = [
        TextSelectionOption(title: "Original"),
        TextSelectionOption(title: "English"),
        TextSelectionOption(title: "Spanish"),
        TextSelectionOption(title: "German"),
        TextSelectionOption(title: "Italian"),
        TextSelectionOption(title: "French"),
    ]

    static let styleSamples: [TextSelectionOption] = [
        TextSelectionOption(title: "Original"),
        TextSelectionOption(title: "Professional"),
        TextSelectionOption(title: "Casual"),
        TextSelectionOption(title: "Friendly"),
    ]
}
