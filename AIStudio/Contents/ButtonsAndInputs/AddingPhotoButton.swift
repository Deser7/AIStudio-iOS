//
//  AddingPhotoButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AddingPhotoButton: View {
    var size: CGFloat
    let action: () -> Void

    private var iconSize: CGFloat { size * 0.6 }
    private var padding: CGFloat { size * 0.3 }
    private var strokeWidth: CGFloat { iconSize * 0.09 }
    private var blurRadius: CGFloat { size * AppSurface.blurRadius * 0.025 }

    private var iconStrokeColor: Color {
        Color.accent.opacity(0.5)
    }

    var body: some View {
        Button(action: action) {
            SettingsIcon()
                .stroke(
                    iconStrokeColor,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: iconSize, height: iconSize)
                .padding(padding)
                .frame(width: size, height: size)
                .background {
                    BlurCardBackground(
                        style: .compact,
                        size: size,
                        blurRadius: blurRadius,
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

#Preview {
    let size: CGFloat = 40

    AddingPhotoButton(size: size) {}
        .padding(24)
        .background(Color.background)
}
