//
//  ProButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ProButton: View {
    var title: String = "PRO"
    var size: CGFloat = 32
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: size * 4 / 32) {
                Text(title)
                    .font(AppFont.font(weight: .regular, size: size * 16 / 32))
                    .foregroundStyle(Color.background)
                    .lineLimit(1)

                Color.clear
                    .frame(width: size * 24 / 32, height: size * 24 / 32)
            }
            .padding(.horizontal, size * 8 / 32)
            .padding(.vertical, size * 4 / 32)
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
