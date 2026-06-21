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
        static let blurRatio: CGFloat = 182.21 / 40
    }

    var size: CGFloat = AddingPhotoButton.defaultSize
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    private var padding: CGFloat { size * Layout.paddingRatio }
    private var iconSize: CGFloat { size * Layout.iconScale }
    private var blurRadius: CGFloat { size * Layout.blurRatio }

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
        .opacity(isEnabled ? 1 : 0.6)
    }

    private var background: some View {
        ZStack {
            BackdropBlurView()
                .frame(
                    width: size + blurRadius * 2,
                    height: size + blurRadius * 2
                )

            Circle()
                .fill(Color.card.opacity(0.4))
        }
    }

    private var iconColor: Color {
        .accent.opacity(0.5)
    }
}

private struct BackdropBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
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
