//
//  ChatService.swift
//  AIStudio
//

import Foundation

struct SendChatMessageResult: Sendable {
    let chatID: String
    let assistantMessage: String
}

protocol ChatServing: Sendable {
    func sendMessage(chatID: String, text: String) async throws -> SendChatMessageResult
}

struct RemoteChatService: ChatServing {
    private let client: any APIClient
    private let configuration: APIConfiguration

    init(
        client: any APIClient = HTTPAPIClient(),
        configuration: APIConfiguration = .live
    ) {
        self.client = client
        self.configuration = configuration
    }

    func sendMessage(chatID: String, text: String) async throws -> SendChatMessageResult {
        let token = APICredentials.bearerToken
        guard !token.isEmpty else { throw APIError.missingBearerToken }

        var components = URLComponents(
            url: configuration.baseURL
                .appending(path: "dola")
                .appending(path: "chats")
                .appending(path: chatID)
                .appending(path: "messages"),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = [
            URLQueryItem(name: "user_id", value: configuration.userID),
            URLQueryItem(name: "app_id", value: configuration.appID)
        ]

        guard let url = components?.url else { throw APIError.invalidURL }

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(SendDolaMessageRequest(message: text))

        let response: SendDolaMessageResponse = try await client.send(request)
        return SendChatMessageResult(
            chatID: response.chatId,
            assistantMessage: response.assistantMessage
        )
    }
}

private struct SendDolaMessageRequest: Encodable {
    let message: String
}

private struct SendDolaMessageResponse: Decodable {
    let chatId: String
    let assistantMessage: String
}
