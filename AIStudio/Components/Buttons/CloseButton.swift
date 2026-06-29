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
        style == .surface ? Color.surface : Color.white
    }

    private var iconSize: CGFloat { size * 16 / 24 }

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
                .fill(Color.white)
        } else {
            CloseIcon()
                .fill(AppGradient.main)
        }
    }
}

#Preview {
    HStack(spacing: 24) {
        CloseButton(size: 24, style: .surface) {}
        CloseButton(size: 48, style: .light) {}
    }
    .padding(24)
    .background(Color.background)
}
