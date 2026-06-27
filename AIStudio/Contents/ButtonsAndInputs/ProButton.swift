//
//  ProButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ProButton: View {
    var title: String = "PRO"
    var size: CGFloat
    let action: () -> Void

    private var spacing: CGFloat { size * 4 / 32 }
    private var fontSize: CGFloat { size * 16 / 32 }
    private var iconPlaceholderSize: CGFloat { size * 24 / 32 }
    private var horizontalPadding: CGFloat { size * 8 / 32 }

    var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                Text(title)
                    .font(AppFont.font(weight: .regular, size: fontSize))
                    .foregroundStyle(Color.background)
                    .lineLimit(1)

                Color.clear
                    .frame(width: iconPlaceholderSize, height: iconPlaceholderSize)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, spacing)
            .frame(height: size)
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
        ProButton(size: size) {}
        ProButton(size: size) {}
            .disabled(true)
    }
    .padding(24)
    .background(Color.background)
}
