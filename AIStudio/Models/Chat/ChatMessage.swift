//
//  ChatMessage.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Foundation

enum ChatMessage: Identifiable, Hashable, Sendable {
    case user(id: UUID = UUID(), text: String, imageFileNames: [String] = [])
    case generating(id: UUID = UUID())
    case assistant(id: UUID = UUID(), content: AIResponseContent)
    case error(id: UUID = UUID(), text: String)

    var id: UUID {
        switch self {
        case let .user(id, _, _),
             let .generating(id),
             let .assistant(id, _),
             let .error(id, _):
            id
        }
    }
}
