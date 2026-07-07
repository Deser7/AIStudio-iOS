//
//  VideoHistoryCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 07.07.2026.
//

import SwiftUI

struct VideoHistoryCard: View {
    let item: VideoHistoryItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Color.clear
                .aspectRatio(item.aspectRatio, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .overlay {
                    Image(item.thumbnailName)
                        .resizable()
                        .scaledToFill()
                }
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 16,
                        style: .continuous
                    )
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VideoHistoryCard(
        item: VideoHistoryItem(thumbnailName: "Card", aspectRatio: 175 / 206),
        action: {}
    )
    .frame(width: 175)
    .padding(24)
    .background(Color.background)
}
