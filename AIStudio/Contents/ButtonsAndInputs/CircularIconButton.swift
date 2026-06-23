//
//  CircularIconButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum CircularIconButtonIcon {
    case photo
    case micro
    case cross
}

struct CircularIconButton: View {
    static let defaultSize: CGFloat = 40

    private enum Layout {
        static let paddingRatio: CGFloat = 12 / 40
        static let iconScale: CGFloat = 24 / 40
        static let strokeScale: CGFloat = 0.09
        static let borderWidthRatio: CGFloat = 1 / 40
    }

    var size: CGFloat = CircularIconButton.defaultSize
    let icon: CircularIconButtonIcon
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var padding: CGFloat { size * Layout.paddingRatio }
    private var iconSize: CGFloat { size * Layout.iconScale }
    private var borderWidth: CGFloat {
        max(size * Layout.borderWidthRatio, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }
    private var strokeWidth: CGFloat {
        (iconSize * Layout.strokeScale).pixelAligned(to: displayScale)
    }

    var body: some View {
        Button(action: action) {
            iconView
                .frame(width: iconSize, height: iconSize)
                .padding(padding)
                .frame(width: size, height: size)
                .overlay {
                    Circle()
                        .strokeBorder(Color.accent.opacity(0.1), lineWidth: borderWidth)
                }
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.6)
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .photo:
            ImportIcon()
                .stroke(
                    Color.accent,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
        case .micro:
            MicIcon()
                .fill(Color.accent, style: FillStyle(eoFill: true))
        case .cross:
            CloseIcon()
                .fill(Color.accent)
        }
    }
}

#Preview("circular icon buttons") {
    VStack(spacing: 24) {
        CircularIconButton(size: 200, icon: .photo) {}
        CircularIconButton(size: 200, icon: .micro) {}
        CircularIconButton(size: 200, icon: .cross) {}
    }
    .padding(24)
    .background(Color.background)
}

#Preview("circular icon buttons — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.1

        HStack(spacing: size * 0.6) {
            CircularIconButton(size: size, icon: .photo) {}
            CircularIconButton(size: size, icon: .micro) {}
            CircularIconButton(size: size, icon: .cross) {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
