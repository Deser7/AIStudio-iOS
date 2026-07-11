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
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost, .timedOut, .cannotFindHost, .cannotConnectToHost, .dnsLookupFailed:
                throw APIError.network
            default:
                throw APIError.network
            }
        }

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200..<300).contains(http.statusCode) else {
            throw Self.mapHTTPStatus(http.statusCode, data: data)
        }

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            let body = String(data: data, encoding: .utf8)
            throw APIError.decoding(error, body)
        }
    }

    private static func mapHTTPStatus(_ code: Int, data: Data) -> APIError {
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
