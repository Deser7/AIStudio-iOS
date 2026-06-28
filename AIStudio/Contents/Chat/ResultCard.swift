//
//  ResultCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Карточка результата генерации (Figma «Result»).
struct ResultCard: View {
    var size: CGFloat
    let onReplace: () -> Void
    let onPlay: () -> Void

    /// Figma ref width = 358, height = 611.
    private var cardHeight: CGFloat { size * 611 / 358 }
    private var cornerRadius: CGFloat { size * 24 / 358 }
    private var replaceButtonSize: CGFloat { size * 40 / 358 }
    private var overlayInset: CGFloat { size * 16 / 358 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        ZStack {
            Image("Result")
                .resizable()
                .scaledToFill()
                .frame(width: size, height: cardHeight)
                .clipped()
        }
        .frame(width: size, height: cardHeight)
        .clipShape(shape)
        .overlay(alignment: .topTrailing) {
            ReplaceButton(size: replaceButtonSize, action: onReplace)
                .padding(.top, overlayInset)
                .padding(.trailing, overlayInset)
        }
    }
}

#Preview {
    let size: CGFloat = 358

    ResultCard(size: size, onReplace: {}, onPlay: {})
}
