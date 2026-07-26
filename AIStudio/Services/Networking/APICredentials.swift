//
//  APICredentials.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

enum APICredentials {
    static var geminiAPIKey: String { string(for: "GeminiAPIKey") }
    static var cerebrasAPIKey: String { string(for: "CerebrasAPIKey") }
    static var openRouterAPIKey: String { string(for: "OpenRouterAPIKey") }

    private static func string(for key: String) -> String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let values = NSDictionary(contentsOf: url),
            let value = values[key] as? String
        else {
            return ""
        }

        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
