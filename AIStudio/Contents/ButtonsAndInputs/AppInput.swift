//
//  AppInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AppInput: View {
    static let defaultSize: CGFloat = InputFieldMetrics.referenceSize

    var placeholder: String = "Ask anything..."
    var size: CGFloat = AppInput.defaultSize
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var metrics: InputFieldMetrics { InputFieldMetrics(size: size) }
    private var borderWidth: CGFloat {
        max(size * 2 / InputFieldMetrics.referenceSize, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }

    var body: some View {
        TextFieldBar(
            placeholder: placeholder,
            size: size,
            text: $text,
            icon: {
                GenerateIcon()
                    .fill(Color.accent, style: FillStyle(eoFill: true))
                    .frame(width: metrics.iconSize, height: metrics.iconSize)
            },
            background: {
                BlurCardBackground(
                    style: .bar,
                    size: size,
                    blurRadius: blurRadius,
                    cardOpacity: AppSurface.CardOpacity.blurOverlay,
                    shape: metrics.shape
                )
            },
            border: {
                GeometryReader { geo in
                    DissolvingGradientBorder(
                        shape: metrics.shape,
                        containerWidth: geo.size.width,
                        lineWidth: borderWidth,
                        cornerRadius: metrics.cornerRadius
                    )
                }
                .allowsHitTesting(false)
            }
        )
    }
}

#Preview("input") {
    AppInputPreview()
        .padding(24)
        .background(Color.green)
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
