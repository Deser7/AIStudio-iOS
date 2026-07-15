//
//  AIResponseContent.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import Foundation

struct AIResponseContent: Hashable, Sendable {
    let title: String
    let paragraphs: [String]
    let bullets: [AIResponseBullet]
    var closingParagraphs: [String] = []
}
