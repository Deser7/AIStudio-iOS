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
    var action: (() -> Void)?

    private var iconSize: CGFloat { size * 24 / 40 }
    private var borderWidth: CGFloat { size * 1 / 40 }
    private var strokeWidth: CGFloat { iconSize * 9 / 100 }

    var body: some View {
        if let action {
            Button(action: action) {
                iconContent
            }
            .buttonStyle(.plain)
        } else {
            iconContent
        }
    }

    private var iconContent: some View {
        iconView
            .frame(width: iconSize, height: iconSize)
            .padding(12)
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .strokeBorder(.white.opacity(0.1), lineWidth: borderWidth)
            }
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .photo:
            ImportIcon()
                .stroke(
                    .white,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
        case .micro:
            MicIcon()
                .fill(.white)
        case .cross:
            CloseIcon()
                .fill(.white)
        }
    }
}

#Preview {
    HStack(spacing: 24) {
        CircularIconButton(size: 20, icon: .photo) {}
        CircularIconButton(size: 40, icon: .micro) {}
        CircularIconButton(size: 60, icon: .cross) {}
    }
    .padding(24)
    .background(Color.background)
}
