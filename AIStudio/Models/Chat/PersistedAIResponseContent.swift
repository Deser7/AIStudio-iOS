//
//  PersistedAIResponseContent.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 11.07.2026.
//

import Foundation

struct PersistedAIResponseContent: Codable, Sendable {
    var title: String
    var paragraphs: [String]
    var bullets: [PersistedAIResponseBullet]
    var closingParagraphs: [String]
}

extension PersistedAIResponseContent {
    init(_ content: AIResponseContent) {
        title = content.title
        paragraphs = content.paragraphs
        bullets = content.bullets.map {
            PersistedAIResponseBullet(emphasis: $0.emphasis, text: $0.text)
        }
        closingParagraphs = content.closingParagraphs
    }

    var asAIResponseContent: AIResponseContent {
        AIResponseContent(
            title: title,
            paragraphs: paragraphs,
            bullets: bullets.map { AIResponseBullet(emphasis: $0.emphasis, text: $0.text) },
            closingParagraphs: closingParagraphs
        )
    }
}
