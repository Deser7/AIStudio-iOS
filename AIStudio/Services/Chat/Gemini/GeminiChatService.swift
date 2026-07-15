//
//  GeminiChatService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

struct GeminiChatService: ChatServing {
    private let session: URLSession
    private let configuration: APIConfiguration
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(
        session: URLSession = .shared,
        configuration: APIConfiguration = .live
    ) {
        self.session = session
        self.configuration = configuration
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
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
        let apiKey = APICredentials.geminiAPIKey
        guard !apiKey.isEmpty else { throw APIError.missingAPIKey }

        guard
            let url = URL(
                string: "\(configuration.baseURL.absoluteString)/models/\(configuration.model):streamGenerateContent?alt=sse"
            )
        else {
            throw APIError.invalidURL
        }

        let trimmedInstruction = systemInstruction?
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let instruction: GeminiRequestContent? =
            if let trimmedInstruction, !trimmedInstruction.isEmpty {
                GeminiRequestContent(
                    role: nil,
                    parts: [.init(text: trimmedInstruction)]
                )
            } else {
                nil
            }

        let requestBody = GeminiGenerateContentRequest(
            systemInstruction: instruction,
            contents: history.map { message in
                GeminiRequestContent(
                    role: message.role.rawValue,
                    parts: Self.parts(for: message)
                )
            }
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-goog-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(requestBody)

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

        for try await line in bytes.lines {
            try Task.checkCancellation()

            guard line.hasPrefix("data:") else { continue }
            let payload = line.dropFirst(5).trimmingCharacters(in: .whitespacesAndNewlines)
            guard !payload.isEmpty, payload != "[DONE]" else {
                if payload == "[DONE]" { break }
                continue
            }

            guard let jsonData = payload.data(using: .utf8) else { continue }

            let chunk: GeminiGenerateContentResponse
            do {
                chunk = try decoder.decode(GeminiGenerateContentResponse.self, from: jsonData)
            } catch {
                throw APIError.decoding(error, payload)
            }

            let text = chunk.candidates?
                .first?
                .content?
                .parts?
                .compactMap(\.text)
                .joined()

            guard let text, !text.isEmpty else { continue }
            yieldedAny = true
            continuation.yield(text)
        }

        guard yieldedAny else {
            throw APIError.emptyResponse
        }
    }

    private static func parts(for message: ChatHistoryMessage) -> [GeminiRequestPart] {
        var parts: [GeminiRequestPart] = []

        if let text = message.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
            parts.append(.init(text: text))
        }

        for image in message.images {
            parts.append(
                .init(
                    inlineData: .init(
                        mimeType: image.mimeType,
                        data: image.data.base64EncodedString()
                    )
                )
            )
        }

        if parts.isEmpty {
            parts.append(.init(text: ""))
        }

        return parts
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
