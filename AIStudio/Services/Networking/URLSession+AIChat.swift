//
//  URLSession+AIChat.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 17.07.2026.
//

import Foundation

extension URLSession {
    /// Shared session for AI providers: 30s request timeout.
    static let aiChat: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()
}
