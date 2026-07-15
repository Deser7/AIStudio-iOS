//
//  GeminiRequestContent.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

struct GeminiRequestContent: Encodable {
    let role: String?
    let parts: [GeminiRequestPart]

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encode(parts, forKey: .parts)
    }

    private enum CodingKeys: String, CodingKey {
        case role
        case parts
    }
}
