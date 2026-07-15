//
//  ChatSessionEntity.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 11.07.2026.
//

import Foundation
import SwiftData

@Model
final class ChatSessionEntity {
    @Attribute(.unique) var id: UUID
    var title: String
    var updatedAt: Date
    var messagesData: Data

    init(
        id: UUID,
        title: String,
        updatedAt: Date = .now,
        messagesData: Data = Data()
    ) {
        self.id = id
        self.title = title
        self.updatedAt = updatedAt
        self.messagesData = messagesData
    }
}
