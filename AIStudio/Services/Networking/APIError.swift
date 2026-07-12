//
//  APIError.swift
//  AIStudio
//

import Foundation

enum APIError: Error, LocalizedError, Sendable {
    case missingAPIKey
    case invalidURL
    case invalidResponse
    case emptyResponse
    case unauthorized
    case rateLimited
    case network
    case httpStatus(Int, String?)
    case decoding(Error, String?)

    var errorDescription: String? {
        let key: String.LocalizationValue = switch self {
        case .missingAPIKey:
            "API key is missing."
        case .invalidURL, .invalidResponse, .decoding:
            "Something went wrong. Please try again."
        case .emptyResponse:
            "Empty response from AI."
        case .unauthorized:
            "Invalid API key."
        case .rateLimited:
            "API limit reached. Try again later."
        case .network:
            "No internet connection."
        case let .httpStatus(code, _):
            switch code {
            case 401, 403:
                "Invalid API key."
            case 429:
                "API limit reached. Try again later."
            default:
                "Something went wrong. Please try again."
            }
        }

        return String(localized: key, locale: LanguageStore.resolvedLocale)
    }
}
