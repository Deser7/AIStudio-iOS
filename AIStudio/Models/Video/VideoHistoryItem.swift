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

enum VideoHistoryStub {
    static let items: [VideoHistoryItem] = [
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 206),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 260),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 180),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 230),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 195),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 250),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 170),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 220),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 240),
        VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 188)
    ]
}
