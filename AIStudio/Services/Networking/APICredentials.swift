//
//  APICredentials.swift
//  AIStudio
//

import Foundation

enum APICredentials {
    static var geminiAPIKey: String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let values = NSDictionary(contentsOf: url),
            let key = values["GeminiAPIKey"] as? String
        else {
            return ""
        }

        return key.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
