//
//  ReplaceButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ReplaceButton: View {
    static let defaultSize: CGFloat = 40

    private enum Layout {
        static let horizontalPaddingRatio: CGFloat = 12 / 40
        static let verticalPaddingRatio: CGFloat = 8 / 40
        static let gapRatio: CGFloat = 8 / 40
        static let fontSizeRatio: CGFloat = 14 / 40
        static let iconSizeRatio: CGFloat = 24 / 40
        static let cornerRadiusRatio: CGFloat = 24 / 40
        static let strokeScale: CGFloat = 0.09
    }

    var title: String = "Replace"
    var size: CGFloat = ReplaceButton.defaultSize
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var horizontalPadding: CGFloat { size * Layout.horizontalPaddingRatio }
    private var verticalPadding: CGFloat { size * Layout.verticalPaddingRatio }
    private var gap: CGFloat { size * Layout.gapRatio }
    private var fontSize: CGFloat { size * Layout.fontSizeRatio }
    private var iconSize: CGFloat { size * Layout.iconSizeRatio }
    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var strokeWidth: CGFloat {
        (iconSize * Layout.strokeScale).pixelAligned(to: displayScale)
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
