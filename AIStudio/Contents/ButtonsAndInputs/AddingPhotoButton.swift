//
//  AddingPhotoButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AddingPhotoButton: View {
    var size: CGFloat = 40
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            SettingsIcon()
                .stroke(
                    Color.accent.opacity(0.5),
                    style: StrokeStyle(
                        lineWidth: size * 24 / 40 * 0.09,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: size * 24 / 40, height: size * 24 / 40)
                .padding(size * 12 / 40)
                .frame(width: size, height: size)
                .background {
                    BlurCardBackground(
                        style: .compact,
                        size: size,
                        blurRadius: AppSurface.scaledBlurRadius(for: size, referenceSize: 40),
                        cardOpacity: AppSurface.CardOpacity.compact,
                        shape: Circle()
                    )
                }
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }
}

#Preview("button/adding a photo") {
    AddingPhotoButton(size: 200) {}
        .padding(24)
        .background(Color.mint)
}

#Preview("button/adding a photo — scaled") {
    GeometryReader { geo in
        AddingPhotoButton(size: geo.size.width * 0.1) {}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
    }
}
