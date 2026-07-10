//
//  APICredentials.swift
//  AIStudio
//

import Foundation

enum APICredentials {
    static var bearerToken: String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let values = NSDictionary(contentsOf: url),
            let token = values["BearerToken"] as? String
        else {
            return ""
        }

        return token.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
