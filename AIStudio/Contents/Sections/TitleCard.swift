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

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Image("Card")
                .resizable()
                .scaledToFill()
                .frame(width: 168, height: 219)

            LinearGradient(
                colors: [Color.card.opacity(0), Color.card],
                startPoint: .top,
                endPoint: .bottom
            )

            Text(title)
                .typography(style: .regular, size: 16)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(8)
        }
        .frame(width: 168, height: 219)
        .clipShape(shape)
    }
}

#Preview {
    TitleCard(title: "Title")
        .padding(24)
        .background(Color.background)
}
