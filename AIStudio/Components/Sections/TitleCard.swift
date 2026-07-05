//
//  TitleCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

struct TitleCard: View {
    let title: String

    private static let aspectRatio: CGFloat = 168 / 219

    var body: some View {
        Color.clear
            .aspectRatio(Self.aspectRatio, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .overlay {
                cardContent
            }
            .clipShape(AppShape.card)
    }

    private var cardContent: some View {
        ZStack(alignment: .bottom) {
            Image("Card")
                .resizable()
                .scaledToFill()

            LinearGradient(
                colors: [.card.opacity(0), .card],
                startPoint: .top,
                endPoint: .bottom
            )

            Text(title)
                .typography(style: .regular16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(8)
        }
    }
}

#Preview("Grid") {
    LazyVGrid(
        columns: [
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible())
        ],
        spacing: 8
    ) {
        ForEach(0..<6, id: \.self) { _ in
            TitleCard(title: "Title")
        }
    }
    .padding(16)
    .background(Color.background)
}

#Preview("Fixed") {
    TitleCard(title: "Title")
        .frame(width: 168)
        .padding(24)
        .background(Color.background)
}
