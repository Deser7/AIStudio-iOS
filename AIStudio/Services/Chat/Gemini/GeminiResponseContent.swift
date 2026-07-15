//
//  GeminiResponseContent.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

struct GeminiResponseContent: Decodable {
    let parts: [GeminiResponsePart]?
}
