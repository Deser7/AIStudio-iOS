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
    var size: CGFloat
    let icon: CircularIconButtonIcon
    let action: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var padding: CGFloat { size * 12 / 40 }
    private var iconSize: CGFloat { size * 24 / 40 }
    private var borderWidth: CGFloat {
        max(size * 1 / 40, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }
    private var strokeWidth: CGFloat {
        (iconSize * 9 / 100).pixelAligned(to: displayScale)
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
        .appDisabledOpacity()
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

#Preview {
    let size: CGFloat = 40

    HStack(spacing: size * 24 / 40) {
        CircularIconButton(size: size, icon: .photo) {}
        CircularIconButton(size: size, icon: .micro) {}
        CircularIconButton(size: size, icon: .cross) {}
    }
    .padding(24)
    .background(Color.background)
}
