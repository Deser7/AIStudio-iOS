//
//  ChatPersistedModels.swift
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

enum PersistedChatMessageKind: String, Codable, Sendable {
    case user
    case assistant
    case error
}

struct PersistedAIResponseBullet: Codable, Sendable {
    var emphasis: String
    var text: String
}

struct PersistedAIResponseContent: Codable, Sendable {
    var title: String
    var paragraphs: [String]
    var bullets: [PersistedAIResponseBullet]
    var closingParagraphs: [String]
}

struct PersistedChatMessage: Codable, Sendable {
    var id: UUID
    var kind: PersistedChatMessageKind
    var text: String?
    var imageFileNames: [String]?
    var assistant: PersistedAIResponseContent?
}

enum ChatMessagePersistenceMapper {
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()

    static func encode(_ messages: [ChatMessage]) -> Data {
        let payload: [PersistedChatMessage] = messages.compactMap { message in
            switch message {
            case let .user(id, text, imageFileNames):
                PersistedChatMessage(
                    id: id,
                    kind: .user,
                    text: text,
                    imageFileNames: imageFileNames.isEmpty ? nil : imageFileNames,
                    assistant: nil
                )
            case let .assistant(id, content):
                PersistedChatMessage(
                    id: id,
                    kind: .assistant,
                    text: nil,
                    imageFileNames: nil,
                    assistant: PersistedAIResponseContent(content)
                )
            case let .error(id, text):
                PersistedChatMessage(
                    id: id,
                    kind: .error,
                    text: text,
                    imageFileNames: nil,
                    assistant: nil
                )
            case .generating:
                nil
            }
        }
        return (try? encoder.encode(payload)) ?? Data()
    }

    static func decode(_ data: Data) -> [ChatMessage] {
        guard !data.isEmpty,
              let payload = try? decoder.decode([PersistedChatMessage].self, from: data)
        else {
            return []
        }

        return payload.compactMap { message in
            switch message.kind {
            case .user:
                let text = message.text ?? ""
                let imageFileNames = message.imageFileNames ?? []
                guard !text.isEmpty || !imageFileNames.isEmpty else { return nil }
                return .user(id: message.id, text: text, imageFileNames: imageFileNames)
            case .assistant:
                guard let assistant = message.assistant else { return nil }
                return .assistant(id: message.id, content: assistant.asAIResponseContent)
            case .error:
                guard let text = message.text else { return nil }
                return .error(id: message.id, text: text)
            }
        }
    }
}

private extension PersistedAIResponseContent {
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
