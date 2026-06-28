//
//  AddingPhotoButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AddingPhotoButton: View {
    var diameter: CGFloat
    let action: () -> Void

    private var iconSize: CGFloat { diameter * 24 / 40 }
    private var padding: CGFloat { diameter * 12 / 40 }
    private var strokeWidth: CGFloat { iconSize * 9 / 100 }
    private var blurRadius: CGFloat { diameter * AppSurface.blurRadius / 40 }

    private var iconStrokeColor: Color {
        Color.white.opacity(0.5)
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
                .frame(width: diameter, height: diameter)
                .background {
                    BlurCardBackground(
                        style: .compact,
                        extent: diameter,
                        blurRadius: blurRadius,
                        cardOpacity: 0.4,
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

    AddingPhotoButton(diameter: size) {}
        .padding(24)
        .background(Color.background)
}
