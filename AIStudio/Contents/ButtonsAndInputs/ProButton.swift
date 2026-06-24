//
//  ProButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ProButton: View {
    static let defaultSize: CGFloat = 32

    var title: String = "PRO"
    var size: CGFloat = ProButton.defaultSize
    let action: () -> Void

    private var horizontalPadding: CGFloat { size * 8 / 32 }
    private var verticalPadding: CGFloat { size * 4 / 32 }
    private var gap: CGFloat { size * 4 / 32 }
    private var fontSize: CGFloat { size * 16 / 32 }
    private var iconSize: CGFloat { size * 24 / 32 }

    var body: some View {
        Button(action: action) {
            HStack(spacing: gap) {
                Text(title)
                    .font(AppFont.font(weight: .regular, size: fontSize))
                    .foregroundStyle(Color.background)
                    .lineLimit(1)

                Color.clear
                    .frame(width: iconSize, height: iconSize)
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

#Preview("PRO button/with text") {
    VStack(spacing: 16) {
        ProButton(size: 50) {}

        ProButton {}
            .disabled(true)
    }
    .padding(24)
    .background(Color.background)
}

#Preview("PRO button/with text — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.08

        ProButton(size: size) {}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
    }
}
