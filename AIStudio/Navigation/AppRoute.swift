//
//  AppRoute.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Foundation

enum AppRoute: Hashable {
    case chat
    case chatHistory
    case videoGeneration
    case videoTemplateDetail(VideoTemplateDetailContext)
    case videoGenerating
    case videoResult
}
