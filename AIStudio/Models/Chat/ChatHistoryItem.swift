//
//  ChatHistoryItem.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation

struct ChatHistoryItem: Identifiable, Hashable, Sendable {
    let id: UUID
    let title: String
    let time: String

    init(
        id: UUID = UUID(),
        title: String,
        time: String
    ) {
        self.id = id
        self.title = title
        self.time = time
    }
}
