//
//  APIConfiguration.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

struct APIConfiguration: Sendable {
    let baseURL: URL
    let model: String

    static let live = APIConfiguration(
        baseURL: URL(string: "https://generativelanguage.googleapis.com/v1beta")!,
        model: "gemini-flash-latest"
    )
}
