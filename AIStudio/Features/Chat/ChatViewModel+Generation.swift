//
//  ChatViewModel+Generation.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

extension ChatViewModel {
    func startGeneration(
        chatID: String,
        history: [ChatHistoryMessage],
        generatingID: UUID
    ) {
        generationTask?.cancel()
        resetRevealState()
        isGenerating = true
        generationTask = Task { [weak self] in
            await self?.generateReply(
                chatID: chatID,
                history: history,
                generatingID: generatingID
            )
        }
    }

    func generateReply(
        chatID: String,
        history: [ChatHistoryMessage],
        generatingID: UUID
    ) async {
        defer {
            isGenerating = false
            generationTask = nil
        }

        var assembled = ""
        var didShowAssistant = false

        do {
            for try await delta in chatService.streamMessage(chatID: chatID, history: history) {
                guard !Task.isCancelled else { return }

                assembled += delta

                if !didShowAssistant {
                    didShowAssistant = true
                    replaceGeneratingWithAssistant(generatingID: generatingID, text: "")
                    beginReveal(assistantID: generatingID)
                }

                enqueueReveal(delta)
            }

            guard !Task.isCancelled else { return }

            if assembled.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                failGeneration(
                    generatingID: generatingID,
                    message: APIError.emptyResponse.localizedDescription
                )
            } else {
                await finishRevealAndPersist()
            }
        } catch is CancellationError {
            return
        } catch let urlError as URLError where urlError.code == .cancelled {
            return
        } catch {
            guard !Task.isCancelled else { return }

            if assembled.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                failGeneration(
                    generatingID: generatingID,
                    message: userFacingMessage(for: error)
                )
            } else {
                await finishRevealAndPersist()
            }
        }
    }

    func replaceGeneratingWithAssistant(generatingID: UUID, text: String) {
        messages.removeAll {
            if case let .generating(id) = $0 { id == generatingID } else { false }
        }
        messages.append(
            .assistant(
                id: generatingID,
                content: AIResponseContent(
                    title: "",
                    paragraphs: [text],
                    bullets: []
                )
            )
        )
    }

    func updateAssistant(id: UUID, text: String) {
        guard let index = messages.firstIndex(where: { $0.id == id }) else { return }
        messages[index] = .assistant(
            id: id,
            content: AIResponseContent(
                title: "",
                paragraphs: [text],
                bullets: []
            )
        )
    }

    func userFacingMessage(for error: Error) -> String {
        if let apiError = error as? APIError {
            return apiError.localizedDescription
        }
        if error is URLError {
            return APIError.network.localizedDescription
        }
        return L10n.string("Something went wrong. Please try again.")
    }

    func failGeneration(generatingID: UUID, message: String) {
        resetRevealState()
        messages.removeAll {
            if case let .generating(id) = $0 { id == generatingID } else { false }
        }
        messages.removeAll { $0.id == generatingID }
        messages.append(.error(text: message))
        persist()
    }
}
