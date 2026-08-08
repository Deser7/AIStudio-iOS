//
//  AppRoute.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Foundation

enum AppRoute: Hashable {
    case chat
    case chatSession(UUID)
    case chatHistory
    case videoGeneration
    case videoHistory
    case videoTemplateDetail(VideoTemplateDetailContext)
    case videoGenerating
    case videoResult
    case aiWriting
    case understandFaster
}
