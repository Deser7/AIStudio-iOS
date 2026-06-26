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

    private var horizontalPadding: CGFloat { size * 12 / 40 }
    private var spacing: CGFloat { size * 8 / 40 }
    private var fontSize: CGFloat { size * 14 / 40 }
    private var iconSize: CGFloat { size * 24 / 40 }
    private var strokeWidth: CGFloat {
        (iconSize * 9 / 100).pixelAligned(to: displayScale)
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
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
            .padding(.vertical, spacing)
            .frame(height: size)
            .background(
                Color.card.opacity(AppSurface.CardOpacity.compact),
                in: RoundedRectangle(cornerRadius: iconSize)
            )
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let size: CGFloat = 40

    VStack(spacing: size * 16 / 40) {
        ReplaceButton(size: size) {}
    }
}
