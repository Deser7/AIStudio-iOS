//
//  VideoHistoryItem.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 07.07.2026.
//

import Foundation

struct VideoHistoryItem: Identifiable, Hashable, Sendable {
    let id: UUID = UUID()
    let thumbnailName: String
    let aspectRatio: CGFloat
}
