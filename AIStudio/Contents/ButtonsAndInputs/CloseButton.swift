//
//  CloseButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct CloseButton: View {
    enum Style {
        case surface
        case light
    }

    var size: CGFloat
    var style: Style = .surface
    let action: () -> Void

    private var backgroundColor: Color {
        style == .surface ? Color.surface : Color.accent
    }

    private var iconSize: CGFloat { size * 0.667 }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(backgroundColor)

                iconView
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var iconView: some View {
        if style == .surface {
            CloseIcon()
                .fill(Color.accent)
        } else {
            CloseIcon()
                .fill(AppGradient.main)
        }
    }
}

#Preview {
    let size: CGFloat = 24

    HStack(spacing: size) {
        CloseButton(size: size, style: .surface) {}
        CloseButton(size: size, style: .light) {}
    }
    .padding(24)
    .background(Color.background)
}
