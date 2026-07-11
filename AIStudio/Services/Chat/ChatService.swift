//
//  ChatService.swift
//  AIStudio
//

import Foundation

struct ChatHistoryMessage: Sendable, Equatable {
    enum Role: String, Sendable {
        case user
        case model
    }

    let role: Role
    let text: String
}

struct SendChatMessageResult: Sendable {
    let chatID: String
    let assistantMessage: String
}

protocol ChatServing: Sendable {
    func sendMessage(
        chatID: String,
        history: [ChatHistoryMessage]
    ) async throws -> SendChatMessageResult
}

struct GeminiChatService: ChatServing {
    private let client: any APIClient
    private let configuration: APIConfiguration

    init(
        client: any APIClient = HTTPAPIClient(),
        configuration: APIConfiguration = .live
    ) {
        self.client = client
        self.configuration = configuration
    }

    func sendMessage(
        chatID: String,
        history: [ChatHistoryMessage]
    ) async throws -> SendChatMessageResult {
        let apiKey = APICredentials.geminiAPIKey
        guard !apiKey.isEmpty else { throw APIError.missingAPIKey }

        guard
            let url = URL(
                string: "\(configuration.baseURL.absoluteString)/models/\(configuration.model):generateContent"
            )
        else {
            throw APIError.invalidURL
        }

        let requestBody = GeminiGenerateContentRequest(
            contents: history.map { message in
                GeminiGenerateContentRequest.Content(
                    role: message.role.rawValue,
                    parts: [.init(text: message.text)]
                )
            }
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-goog-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestBody)

        let response: GeminiGenerateContentResponse = try await client.send(request)

        let text = response.candidates?
            .first?
            .content?
            .parts?
            .compactMap(\.text)
            .joined()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let text, !text.isEmpty else {
            throw APIError.emptyResponse
        }

        return SendChatMessageResult(
            chatID: chatID,
            assistantMessage: text
        )
    }
}

private struct GeminiGenerateContentRequest: Encodable {
    let contents: [Content]

    struct Content: Encodable {
        let role: String
        let parts: [Part]
    }

    struct Part: Encodable {
        let text: String
    }
}

private struct GeminiGenerateContentResponse: Decodable {
    let candidates: [Candidate]?

    struct Candidate: Decodable {
        let content: Content?
    }

    struct Content: Decodable {
        let parts: [Part]?
    }

    struct Part: Decodable {
        let text: String?
    }
}
