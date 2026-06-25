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

#Preview {
    AppInputPreview()
}

private struct AppInputPreview: View {
    @State private var text = ""

    var body: some View {
        let size = AppInput.defaultSize

        VStack(spacing: size * 0.24) {
            AppInput(size: size, text: $text)
            AppInput(size: size * 0.7, text: $text)
            AppInput(size: size, text: $text)
                .disabled(true)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
    }
}
