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

    private var contentSpacing: CGFloat { size * 0.125 }
    private var fontSize: CGFloat { size * 0.5 }
    private var iconPlaceholderSize: CGFloat { size * 0.75 }
    private var horizontalPadding: CGFloat { size * 0.25 }
    private var verticalPadding: CGFloat { size * 0.125 }

    var body: some View {
        Button(action: action) {
            HStack(spacing: contentSpacing) {
                Text(title)
                    .font(AppFont.font(weight: .regular, size: fontSize))
                    .foregroundStyle(Color.background)
                    .lineLimit(1)

                Color.clear
                    .frame(width: iconPlaceholderSize, height: iconPlaceholderSize)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(height: size)
            .background(Color.accent, in: Capsule())
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }
}

#Preview {
    let size: CGFloat = 32

    VStack(spacing: size * 0.5) {
        ProButton(size: size) {}
        ProButton(size: size) {}
            .disabled(true)
    }
    .padding(24)
    .background(Color.background)
}
