//
//  AppInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AppInput: View {
    static let defaultSize: CGFloat = 56

    private enum Layout {
        static let paddingRatio: CGFloat = 16 / 56
        static let gapRatio: CGFloat = 16 / 56
        static let fontSizeRatio: CGFloat = 16 / 56
        static let iconSizeRatio: CGFloat = 24 / 56
        static let cornerRadiusRatio: CGFloat = 24 / 56
        static let borderWidthRatio: CGFloat = 2 / 56
        static let blurRatio: CGFloat = 182.21 / 56
        static let placeholderOpacity: CGFloat = 0.5
    }

    var placeholder: String = "Ask anything..."
    var size: CGFloat = AppInput.defaultSize
    @Binding var text: String

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var padding: CGFloat { size * Layout.paddingRatio }
    private var gap: CGFloat { size * Layout.gapRatio }
    private var fontSize: CGFloat { size * Layout.fontSizeRatio }
    private var iconSize: CGFloat { size * Layout.iconSizeRatio }
    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var borderWidth: CGFloat {
        pixelAligned(max(size * Layout.borderWidthRatio, 1 / displayScale))
    }
    private var blurRadius: CGFloat { size * Layout.blurRatio }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private func pixelAligned(_ value: CGFloat) -> CGFloat {
        (value * displayScale).rounded() / displayScale
    }

    var body: some View {
        HStack(spacing: gap) {
            GenerateIcon()
                .fill(Color.accent, style: FillStyle(eoFill: true))
                .frame(width: iconSize, height: iconSize)

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(AppFont.font(weight: .regular, size: fontSize))
                    .foregroundColor(Color.accent.opacity(Layout.placeholderOpacity))
            )
            .font(AppFont.font(weight: .regular, size: fontSize))
            .foregroundColor(Color.accent)
            .tint(Color.accent)
        }
        .padding(padding)
        .frame(maxWidth: .infinity)
        .frame(height: size)
        .background { background }
        .clipShape(shape)
        .overlay {
            GeometryReader { geo in
                dissolvingBorder(width: geo.size.width)
            }
            .allowsHitTesting(false)
        }
        .opacity(isEnabled ? 1 : 0.6)
    }

    private var background: some View {
        ZStack {
            BackdropBlurView()
                .frame(
                    width: blurRadius * 4,
                    height: size + blurRadius * 2
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            shape
                .fill(Color.card.opacity(0.7))
        }
    }

    private func dissolvingBorder(width: CGFloat) -> some View {
        let mask = dissolvingBorderMask(width: width)

        return ZStack {
            shape
                .strokeBorder(AppGradient.main, lineWidth: borderWidth)
                .mask(mask)
                .blur(radius: borderWidth * 0.75)
                .opacity(0.55)

            shape
                .strokeBorder(AppGradient.main, lineWidth: borderWidth)
                .mask(mask)
        }
    }

    /// Прозрачность в центре каждого скругления (слева/справа), ярче на прямых верхнем и нижнем краях.
    private func dissolvingBorderMask(width: CGFloat) -> LinearGradient {
        let cap = min(cornerRadius / max(width, 1), 0.5)
        let fadeEnd = cap
        let fadeStart = cap * 0.45
        let solidStart = min(cap * 1.15, 0.5)

        return LinearGradient(
            stops: [
                .init(color: .clear, location: 0),
                .init(color: .white.opacity(0.2), location: fadeStart),
                .init(color: .white.opacity(0.8), location: fadeEnd),
                .init(color: .white, location: solidStart),
                .init(color: .white, location: 1 - solidStart),
                .init(color: .white.opacity(0.8), location: 1 - fadeEnd),
                .init(color: .white.opacity(0.2), location: 1 - fadeStart),
                .init(color: .clear, location: 1)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

private struct BackdropBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview("input") {
    AppInputPreview()
        .padding(24)
        .background(Color.background)
}

#Preview("input — scaled") {
    AppInputScaledPreview()
}

private struct AppInputScaledPreview: View {
    @State private var text = ""

    var body: some View {
        GeometryReader { geo in
            let size = geo.size.width * 0.14

            AppInput(size: size, text: $text)
                .padding(.horizontal, geo.size.width * 0.064)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
        }
    }
}

private struct AppInputPreview: View {
    @State private var text = ""

    var body: some View {
        VStack(spacing: 24) {
            AppInput(text: $text)

            AppInput(size: 100, text: $text)

            AppInput(text: $text)
                .disabled(true)
        }
    }
}
