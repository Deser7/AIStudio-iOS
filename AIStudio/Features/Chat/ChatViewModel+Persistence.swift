//
//  ChatViewModel+Persistence.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

extension ChatViewModel {
    func makeHistory() -> [ChatHistoryMessage] {
        messages.compactMap { message -> ChatHistoryMessage? in
            switch message {
            case let .user(_, text, imageFileNames):
                let images = imageFileNames.compactMap { fileName -> ChatInlineImage? in
                    guard let data = ChatImageStore.loadData(sessionID: sessionID, fileName: fileName)
                    else {
                        return nil
                    }
                    return ChatInlineImage(mimeType: ChatImageEncoder.mimeType, data: data)
                }
                let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                return ChatHistoryMessage(
                    role: .user,
                    text: trimmed.isEmpty ? nil : trimmed,
                    images: images
                )
            case let .assistant(_, content):
                return ChatHistoryMessage(role: .model, text: plainText(from: content))
            case .generating, .error:
                return nil
            }
        }
    }

    func plainText(from content: AIResponseContent) -> String {
        var parts: [String] = []
        if !content.title.isEmpty {
            parts.append(content.title)
        }
        parts.append(contentsOf: content.paragraphs)
        for bullet in content.bullets {
            parts.append("• \(bullet.emphasis) \(bullet.text)")
        }
        parts.append(contentsOf: content.closingParagraphs)
        return parts.joined(separator: "\n\n")
    }

    func persist() {
        let fallbackTitle = messages.lazy.compactMap { message -> String? in
            if case let .user(_, text, imageFileNames) = message {
                let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                if !trimmed.isEmpty { return trimmed }
                if !imageFileNames.isEmpty { return L10n.string("Photo") }
            }
            return nil
        }.first ?? L10n.string("New Chat")

        repository.upsert(
            id: sessionID,
            fallbackTitle: fallbackTitle,
            messages: messages,
            direction: selectedDirection
        )
        subtitleDate = .now
    }
}
