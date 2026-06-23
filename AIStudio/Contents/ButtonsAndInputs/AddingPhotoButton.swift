//
//  AddingPhotoButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AddingPhotoButton: View {
    static let defaultSize: CGFloat = 40

    private enum Layout {
        static let paddingRatio: CGFloat = 12 / 40
        static let iconScale: CGFloat = 24 / 40
        static let strokeScale: CGFloat = 0.09
    }

    var size: CGFloat = AddingPhotoButton.defaultSize
    let action: () -> Void

    private var padding: CGFloat { size * Layout.paddingRatio }
    private var iconSize: CGFloat { size * Layout.iconScale }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }

    var body: some View {
        Button(action: action) {
            SettingsIcon()
                .stroke(
                    iconColor,
                    style: StrokeStyle(
                        lineWidth: iconSize * Layout.strokeScale,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: iconSize, height: iconSize)
                .padding(padding)
                .frame(width: size, height: size)
                .background { background }
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }

    private var background: some View {
        BlurCardBackground(
            style: .compact,
            size: size,
            blurRadius: blurRadius,
            cardOpacity: AppSurface.CardOpacity.compact,
            shape: Circle()
        )
    }

    private var iconColor: Color {
        .accent.opacity(0.5)
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
