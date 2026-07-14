//
//  APICredentials.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
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
