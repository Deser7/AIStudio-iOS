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
    let preview: String
    let direction: ChatDirection
}
