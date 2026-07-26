//
//  OpenAICompatibleChatService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 17.07.2026.
//

import Foundation

/// Shared OpenAI-compatible streaming client (Cerebras, OpenRouter).
struct OpenAICompatibleChatService: ChatServing {
    private let baseURL: URL
    private let models: [String]
    private let apiKey: @Sendable () -> String
    private let extraHeaders: [String: String]
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(
        baseURL: URL,
        models: [String],
        apiKey: @escaping @Sendable () -> String,
        extraHeaders: [String: String] = [:],
        session: URLSession = .aiChat
    ) {
        self.baseURL = baseURL
        self.models = models
        self.apiKey = apiKey
        self.extraHeaders = extraHeaders
        self.session = session
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
    }

    static var cerebras: OpenAICompatibleChatService {
        OpenAICompatibleChatService(
            baseURL: URL(string: "https://api.cerebras.ai/v1")!,
            models: [
                "llama-3.3-70b",
                "llama3.1-8b",
            ],
            apiKey: { APICredentials.cerebrasAPIKey }
        )
    }

    static var openRouter: OpenAICompatibleChatService {
        OpenAICompatibleChatService(
            baseURL: URL(string: "https://openrouter.ai/api/v1")!,
            models: [
                "google/gemini-2.5-flash:free",
                "deepseek/deepseek-chat-v3",
                "qwen/qwen3-235b-a22b",
            ],
            apiKey: { APICredentials.openRouterAPIKey },
            extraHeaders: [
                "HTTP-Referer": "https://aistudio.app",
                "X-Title": "AIStudio",
            ]
        )
    }

    func streamMessage(
        chatID _: String,
        history: [ChatHistoryMessage],
        systemInstruction: String?
    ) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    try await stream(
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

    private func stream(
        history: [ChatHistoryMessage],
        systemInstruction: String?,
        continuation: AsyncThrowingStream<String, Error>.Continuation
    ) async throws {
        let key = apiKey()
        guard !key.isEmpty else { throw APIError.missingAPIKey }
        guard !models.isEmpty else { throw APIError.invalidURL }

        var lastError: Error?

        for model in models {
            do {
                try await streamModel(
                    model: model,
                    apiKey: key,
                    history: history,
                    systemInstruction: systemInstruction,
                    continuation: continuation
                )
                return
            } catch is CancellationError {
                throw CancellationError()
            } catch let error as PartialStreamFailure {
                throw error.underlying
            } catch let error as APIError where shouldTryNextModel(error) {
                lastError = error
                continue
            } catch {
                throw error
            }
        }

        throw lastError ?? APIError.emptyResponse
    }

    private func shouldTryNextModel(_ error: APIError) -> Bool {
        if error.isFailoverEligible { return true }
        // Model missing / no endpoints / payment required for that slug.
        if case let .httpStatus(code, _) = error, code == 404 || code == 402 {
            return true
        }
        return false
    }

    private func streamModel(
        model: String,
        apiKey: String,
        history: [ChatHistoryMessage],
        systemInstruction: String?,
        continuation: AsyncThrowingStream<String, Error>.Continuation
    ) async throws {
        let url = baseURL.appending(path: "chat/completions")

        var messages: [OpenAIChatMessage] = []

        if let instruction = systemInstruction?
            .trimmingCharacters(in: .whitespacesAndNewlines),
            !instruction.isEmpty
        {
            messages.append(.init(role: "system", content: instruction))
        }

        for message in history {
            let text = message.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            guard !text.isEmpty else { continue }
            messages.append(
                .init(
                    role: message.role == .model ? "assistant" : "user",
                    content: text
                )
            )
        }

        let body = OpenAIChatCompletionRequest(
            model: model,
            messages: messages,
            stream: true
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (header, value) in extraHeaders {
            request.setValue(value, forHTTPHeaderField: header)
        }
        request.httpBody = try encoder.encode(body)

        let bytes: URLSession.AsyncBytes
        let response: URLResponse

        do {
            (bytes, response) = try await session.bytes(for: request)
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost, .timedOut,
                 .cannotFindHost, .cannotConnectToHost, .dnsLookupFailed:
                throw APIError.network
            default:
                throw APIError.network
            }
        }

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200..<300).contains(http.statusCode) else {
            var errorData = Data()
            for try await byte in bytes {
                errorData.append(byte)
                if errorData.count > 8_192 { break }
            }
            throw mapHTTPStatus(http.statusCode, data: errorData)
        }

        var yieldedAny = false

        do {
            for try await line in bytes.lines {
                try Task.checkCancellation()

                guard line.hasPrefix("data:") else { continue }
                let payload = line.dropFirst(5).trimmingCharacters(in: .whitespacesAndNewlines)
                guard !payload.isEmpty, payload != "[DONE]" else {
                    if payload == "[DONE]" { break }
                    continue
                }

                guard let jsonData = payload.data(using: .utf8) else { continue }

                let chunk: OpenAIChatCompletionChunk
                do {
                    chunk = try decoder.decode(OpenAIChatCompletionChunk.self, from: jsonData)
                } catch {
                    throw APIError.decoding(error, payload)
                }

                let text = chunk.choices?
                    .compactMap(\.delta?.content)
                    .joined()

                guard let text, !text.isEmpty else { continue }
                yieldedAny = true
                continuation.yield(text)
            }
        } catch {
            if yieldedAny {
                throw PartialStreamFailure(underlying: error)
            }
            throw error
        }

        guard yieldedAny else {
            throw APIError.emptyResponse
        }
    }

    private func mapHTTPStatus(_ code: Int, data: Data) -> APIError {
        switch code {
        case 401, 403:
            return .unauthorized
        case 429:
            return .rateLimited
        default:
            let message = String(data: data, encoding: .utf8)
            return .httpStatus(code, message)
        }
    }
}

/// Marks that tokens were already yielded — caller must not try the next model.
private struct PartialStreamFailure: Error {
    let underlying: Error
}

// MARK: - DTOs

private struct OpenAIChatCompletionRequest: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
    let stream: Bool
}

private struct OpenAIChatMessage: Encodable {
    let role: String
    let content: String
}

private struct OpenAIChatCompletionChunk: Decodable {
    let choices: [Choice]?

    struct Choice: Decodable {
        let delta: Delta?
    }

    struct Delta: Decodable {
        let content: String?
    }
}
