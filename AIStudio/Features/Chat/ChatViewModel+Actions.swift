//
//  ChatViewModel+Actions.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

extension ChatViewModel {
    func sendTapped() {
        let trimmed = promptText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard (!trimmed.isEmpty || !pendingAttachments.isEmpty), !isGenerating else { return }

        let attachmentsSnapshot = pendingAttachments
        promptText = ""
        pendingAttachments = []

        if let editingID = editingUserMessageID {
            editingUserMessageID = nil
            resendEditedPrompt(id: editingID, text: trimmed, attachments: attachmentsSnapshot)
            return
        }

        let imageFileNames = persistAttachments(attachmentsSnapshot)
        let userID = UUID()
        let generatingID = UUID()
        let activeChatID = resolvedChatID()

        messages.append(.user(id: userID, text: trimmed, imageFileNames: imageFileNames))
        messages.append(.generating(id: generatingID))
        requestScrollPin(to: userID)

        startGeneration(
            chatID: activeChatID,
            history: makeHistory(),
            generatingID: generatingID
        )
    }

    func copyUserPromptTapped(_ messageID: UUID) -> String? {
        guard case let .user(_, text, _) = messages.first(where: { $0.id == messageID }) else {
            return nil
        }
        return text
    }

    func editUserPromptTapped(_ messageID: UUID) {
        guard !isGenerating else { return }
        guard case let .user(_, text, imageFileNames) = messages.first(where: { $0.id == messageID })
        else {
            return
        }
        editingUserMessageID = messageID
        promptText = text
        pendingAttachments = imageFileNames.compactMap { fileName in
            guard let data = ChatImageStore.loadData(sessionID: sessionID, fileName: fileName) else {
                return nil
            }
            return PendingChatAttachment(
                id: UUID(),
                imageData: data,
                existingFileName: fileName
            )
        }
    }

    func imageData(for message: ChatMessage) -> [Data] {
        guard case let .user(_, _, imageFileNames) = message else { return [] }
        return imageFileNames.compactMap { fileName in
            ChatImageStore.loadData(sessionID: sessionID, fileName: fileName)
        }
    }

    func copyResponseTapped(_ messageID: UUID) -> String? {
        guard case let .assistant(_, content) = messages.first(where: { $0.id == messageID }) else {
            return nil
        }
        return plainText(from: content)
    }

    func refreshResponseTapped(_ messageID: UUID) {
        guard !isGenerating else { return }
        guard let assistantIndex = messages.firstIndex(where: { $0.id == messageID }),
              case .assistant = messages[assistantIndex],
              assistantIndex > 0,
              case let .user(userID, _, _) = messages[assistantIndex - 1]
        else {
            return
        }

        editingUserMessageID = nil

        messages.removeSubrange(assistantIndex...)

        let generatingID = UUID()
        let activeChatID = resolvedChatID()
        messages.append(.generating(id: generatingID))
        requestScrollPin(to: userID)

        startGeneration(
            chatID: activeChatID,
            history: makeHistory(),
            generatingID: generatingID
        )
    }

    func resendEditedPrompt(
        id: UUID,
        text: String,
        attachments: [PendingChatAttachment]
    ) {
        guard let index = messages.firstIndex(where: { $0.id == id }),
              case let .user(_, _, oldFileNames) = messages[index]
        else {
            return
        }

        let imageFileNames = persistAttachments(attachments)
        let removed = Set(oldFileNames).subtracting(imageFileNames)
        ChatImageStore.delete(sessionID: sessionID, fileNames: Array(removed))

        messages[index] = .user(id: id, text: text, imageFileNames: imageFileNames)
        if index + 1 < messages.count {
            messages.removeSubrange((index + 1)...)
        }

        let generatingID = UUID()
        let activeChatID = resolvedChatID()
        messages.append(.generating(id: generatingID))
        requestScrollPin(to: id)

        startGeneration(
            chatID: activeChatID,
            history: makeHistory(),
            generatingID: generatingID
        )
    }
}
