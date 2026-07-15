//
//  AICreationOption.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import Foundation

enum AICreationOption: CaseIterable, Identifiable, Sendable {
    case talkToAI
    case createVideos
    case writeLikePro
    case understandFaster

    var id: Self { self }

    var title: String {
        switch self {
        case .talkToAI: "Talk to AI"
        case .createVideos: "Create videos"
        case .writeLikePro: "Write like a pro"
        case .understandFaster: "Understand faster"
        }
    }

    var subtitle: String {
        switch self {
        case .talkToAI: "Ask anything. Get answers fast"
        case .createVideos: "Pick a template. Done in seconds"
        case .writeLikePro: "Rewrite and improve your text"
        case .understandFaster: "Simplify complex info instantly"
        }
    }
}
