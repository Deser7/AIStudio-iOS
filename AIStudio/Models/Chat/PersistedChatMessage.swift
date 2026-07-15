//
//  PersistedChatMessage.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 11.07.2026.
//

import Foundation

struct PersistedChatMessage: Codable, Sendable {
    var id: UUID
    var kind: PersistedChatMessageKind
    var text: String?
    var imageFileNames: [String]?
    var assistant: PersistedAIResponseContent?
}
