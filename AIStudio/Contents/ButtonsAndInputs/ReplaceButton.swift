//
//  ReplaceButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ReplaceButton: View {
    var title: String = "Replace"
    var size: CGFloat
    let action: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var horizontalPadding: CGFloat { size * 0.3 }
    private var verticalPadding: CGFloat { size * 0.2 }
    private var gap: CGFloat { size * 0.2 }
    private var fontSize: CGFloat { size * 0.35 }
    private var iconSize: CGFloat { size * 0.6 }
    private var cornerRadius: CGFloat { size * 0.6 }
    private var strokeWidth: CGFloat {
        (iconSize * 0.09).pixelAligned(to: displayScale)
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: gap) {
                RefreshIcon()
                    .stroke(
                        Color.accent,
                        style: StrokeStyle(
                            lineWidth: strokeWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: iconSize, height: iconSize)

                Text(title)
                    .font(AppFont.font(weight: .regular, size: fontSize))
                    .foregroundStyle(Color.accent)
                    .lineLimit(1)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(height: size)
            .background(
                Color.card.opacity(AppSurface.CardOpacity.compact),
                in: RoundedRectangle(cornerRadius: cornerRadius)
            )
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let size: CGFloat = 40

    VStack(spacing: size * 0.4) {
        ReplaceButton(size: size) {}
        ReplaceButton(size: size * 2) {}
        ReplaceButton(size: size) {}
            .disabled(true)
    }
    .padding(24)
    .background(Color.background)
}
