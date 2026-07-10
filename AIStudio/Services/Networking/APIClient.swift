//
//  APIClient.swift
//  AIStudio
//

import Foundation

protocol APIClient: Sendable {
    func send<Response: Decodable>(_ request: URLRequest) async throws -> Response
}

struct HTTPAPIClient: APIClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }

    func send<Response: Decodable>(_ request: URLRequest) async throws -> Response {
        let (data, response) = try await session.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200..<300).contains(http.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            throw APIError.httpStatus(http.statusCode, message)
        }

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            let body = String(data: data, encoding: .utf8)
            throw APIError.decoding(error, body)
        }
    }
}
