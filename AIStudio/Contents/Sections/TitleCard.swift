//
//  TitleCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

/// Карточка с изображением и заголовком (Figma «card»).
struct TitleCard: View {
    let title: String
    var size: CGFloat

    /// Figma ref width = 168, height = 219.
    private var cardHeight: CGFloat { size * 219 / 168 }
    private var cornerRadius: CGFloat { size * 24 / 168 }
    private var padding: CGFloat { size * 8 / 168 }
    private var titleFontSize: CGFloat { size * 16 / 168 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Image("Card")
                .resizable()
                .scaledToFill()
                .frame(width: size, height: cardHeight)

            LinearGradient(
                colors: [Color.card.opacity(0), Color.card],
                startPoint: .top,
                endPoint: .bottom
            )

            Text(title)
                .typography(Typography.regular(size: titleFontSize))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(padding)
        }
        .frame(width: size, height: cardHeight)
        .clipShape(shape)
    }
}

#Preview {
    TitleCard(title: "Title", size: 168)
        .padding(24)
        .background(Color.background)
}
