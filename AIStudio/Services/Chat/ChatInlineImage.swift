//
//  ChatInlineImage.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

struct ChatInlineImage: Sendable, Equatable {
    let mimeType: String
    let data: Data
}
