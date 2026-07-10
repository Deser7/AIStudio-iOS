//
//  APIError.swift
//  AIStudio
//

import Foundation

enum APIError: Error, LocalizedError, Sendable {
    case missingBearerToken
    case invalidURL
    case invalidResponse
    case httpStatus(Int, String?)
    case decoding(Error, String?)

    var errorDescription: String? {
        switch self {
        case .missingBearerToken:
            "Missing API token. Add BearerToken to Secrets.plist."
        case .invalidURL:
            "Invalid request URL."
        case .invalidResponse:
            "Invalid server response."
        case let .httpStatus(code, message):
            message?.isEmpty == false ? message : "Request failed (\(code))."
        case let .decoding(error, body):
            [
                "Failed to decode server response.",
                error.localizedDescription,
                body
            ]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
        }
    }
}
