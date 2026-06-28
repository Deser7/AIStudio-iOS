//
//  ProButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ProButton: View {
    var title: String = "PRO"
    var height: CGFloat
    let action: () -> Void

    private var spacing: CGFloat { height * 4 / 32 }
    private var fontSize: CGFloat { height * 16 / 32 }
    private var iconPlaceholderSize: CGFloat { height * 24 / 32 }
    private var horizontalPadding: CGFloat { height * 8 / 32 }

    var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                Text(title)
                    .typography(style: .regular, size: fontSize)
                    .foregroundStyle(Color.background)
                    .lineLimit(1)

                Color.clear
                    .frame(width: iconPlaceholderSize, height: iconPlaceholderSize)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, spacing)
            .frame(height: height)
            .background(Color.white, in: Capsule())
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }
}

#Preview {
    let size: CGFloat = 32

    VStack(spacing: size * 16 / 32) {
        ProButton(height: size) {}
        ProButton(height: size) {}
            .disabled(true)
    }
    .padding(24)
    .background(Color.background)
}
