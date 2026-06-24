//
//  ReplaceButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ReplaceButton: View {
    static let defaultSize: CGFloat = 40

    var title: String = "Replace"
    var size: CGFloat = ReplaceButton.defaultSize
    let action: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var horizontalPadding: CGFloat { size * 12 / 40 }
    private var verticalPadding: CGFloat { size * 8 / 40 }
    private var gap: CGFloat { size * 8 / 40 }
    private var fontSize: CGFloat { size * 14 / 40 }
    private var iconSize: CGFloat { size * 24 / 40 }
    private var cornerRadius: CGFloat { size * 24 / 40 }
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

#Preview("Replace") {
    VStack(spacing: 16) {
        ReplaceButton {}

        ReplaceButton(size: 200) {}

        ReplaceButton {}
            .disabled(true)
    }
    .padding(24)
    .background(Color.orange)
}

#Preview("Replace — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.1

        ReplaceButton(size: size) {}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
    }
}
