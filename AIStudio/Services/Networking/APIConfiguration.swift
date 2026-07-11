//
//  APIConfiguration.swift
//  AIStudio
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
