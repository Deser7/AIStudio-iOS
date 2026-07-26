//
//  FailoverChatService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 17.07.2026.
//

import Foundation

/// Routes text generation: Gemini → OpenRouter → Cerebras.
/// Multimodal (images) stays on Gemini only.
struct FailoverChatService: ChatServing {
    struct Provider: Sendable {
        let name: String
        let service: any ChatServing
        let supportsImages: Bool
    }

    private let providers: [Provider]

    init(providers: [Provider]) {
        self.providers = providers
    }

    static let live = FailoverChatService(
        providers: [
            Provider(name: "Gemini", service: GeminiChatService(), supportsImages: true),
            Provider(
                name: "OpenRouter",
                service: OpenAICompatibleChatService.openRouter,
                supportsImages: false
            ),
            Provider(name: "Cerebras", service: OpenAICompatibleChatService.cerebras, supportsImages: false),
        ]
    )

    func streamMessage(
        chatID: String,
        history: [ChatHistoryMessage],
        systemInstruction: String?
    ) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    try await route(
                        chatID: chatID,
                        history: history,
                        systemInstruction: systemInstruction,
                        continuation: continuation
                    )
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }

            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }

    private func route(
        chatID: String,
        history: [ChatHistoryMessage],
        systemInstruction: String?,
        continuation: AsyncThrowingStream<String, Error>.Continuation
    ) async throws {
        let hasImages = history.contains { !$0.images.isEmpty }
        let chain = hasImages
            ? providers.filter(\.supportsImages)
            : providers

        guard !chain.isEmpty else {
            throw APIError.invalidResponse
        }

        var lastError: Error?
        var isFirstAttempt = true

        for provider in chain {
            if isFirstAttempt {
                print("[AI] Provider: \(provider.name)")
                isFirstAttempt = false
            } else {
                print("[AI] Fallback -> \(provider.name)")
            }

            var yieldedAny = false

            do {
                for try await chunk in provider.service.streamMessage(
                    chatID: chatID,
                    history: history,
                    systemInstruction: systemInstruction
                ) {
                    yieldedAny = true
                    continuation.yield(chunk)
                }
                return
            } catch is CancellationError {
                throw CancellationError()
            } catch {
                lastError = error

                // Mid-stream failure: do not restart on another provider.
                if yieldedAny {
                    throw error
                }

                if shouldFailover(error) {
                    continue
                }

                throw error
            }
        }

        throw lastError ?? APIError.emptyResponse
    }

    private func shouldFailover(_ error: Error) -> Bool {
        if let apiError = error as? APIError {
            return apiError.isFailoverEligible
        }
        if error is URLError {
            return true
        }
        return false
    }
}
