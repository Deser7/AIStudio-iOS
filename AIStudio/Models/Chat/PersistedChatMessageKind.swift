//
//  PersistedChatMessageKind.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 11.07.2026.
//

import Foundation

enum PersistedChatMessageKind: String, Codable, Sendable {
    case user
    case assistant
    case error
}
