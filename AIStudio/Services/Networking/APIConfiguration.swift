//
//  APIConfiguration.swift
//  AIStudio
//

import Foundation

struct APIConfiguration: Sendable {
    let baseURL: URL
    let appID: String
    let userID: String

    static let live = APIConfiguration(
        baseURL: URL(string: "https://nebulaapps.site")!,
        appID: "com.test.test",
        userID: "test-user"
    )
}
