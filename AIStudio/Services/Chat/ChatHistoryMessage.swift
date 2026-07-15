//
//  ChatHistoryMessage.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

struct ChatHistoryMessage: Sendable, Equatable {
    let role: ChatHistoryMessageRole
    let text: String?
    let images: [ChatInlineImage]

    init(
        role: ChatHistoryMessageRole,
        text: String?,
        images: [ChatInlineImage] = []
    ) {
        self.role = role
        self.text = text
        self.images = images
    }
}
