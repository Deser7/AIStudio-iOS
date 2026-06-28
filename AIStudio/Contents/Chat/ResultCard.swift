//
//  ResultCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Карточка результата генерации (Figma «Result»).
struct ResultCard: View {
    var width: CGFloat
    let onReplace: () -> Void
    let onPlay: () -> Void

    /// Figma ref width = 358, height = 611.
    private var cardHeight: CGFloat { width * 611 / 358 }
    private var cornerRadius: CGFloat { width * 24 / 358 }
    private var replaceButtonSize: CGFloat { width * 40 / 358 }
    private var overlayInset: CGFloat { width * 16 / 358 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        ZStack {
            Image("Result")
                .resizable()
                .scaledToFill()
                .frame(width: width, height: cardHeight)
                .clipped()
        }
        .frame(width: width, height: cardHeight)
        .clipShape(shape)
        .overlay(alignment: .topTrailing) {
            ReplaceButton(height: replaceButtonSize, action: onReplace)
                .padding(.top, overlayInset)
                .padding(.trailing, overlayInset)
        }
    }
}

#Preview {
    let size: CGFloat = 358

    ResultCard(width: size, onReplace: {}, onPlay: {})
}
