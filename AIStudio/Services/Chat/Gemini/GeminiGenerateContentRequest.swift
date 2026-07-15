//
//  GeminiGenerateContentRequest.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

struct GeminiGenerateContentRequest: Encodable {
    let systemInstruction: GeminiRequestContent?
    let contents: [GeminiRequestContent]

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(systemInstruction, forKey: .systemInstruction)
        try container.encode(contents, forKey: .contents)
    }

    private enum CodingKeys: String, CodingKey {
        case systemInstruction
        case contents
    }
}
