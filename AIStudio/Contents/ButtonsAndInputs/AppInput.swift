//
//  AppInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AppInput: View {
    var placeholder: String = "Ask anything..."
    var size: CGFloat
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var iconSize: CGFloat { size * 3 / 7 }
    private var borderWidth: CGFloat {
        max(size * 1 / 28, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }
    private var blurRadius: CGFloat { size * AppSurface.blurRadius / 56 }

    private var fieldShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: iconSize, style: .continuous)
    }

    var body: some View {
        TextFieldBar(
            placeholder: placeholder,
            size: size,
            text: $text,
            icon: {
                GenerateIcon()
                    .fill(Color.accent, style: FillStyle(eoFill: true))
                    .frame(width: iconSize, height: iconSize)
            },
            background: {
                BlurCardBackground(
                    style: .bar,
                    size: size,
                    blurRadius: blurRadius,
                    cardOpacity: AppSurface.CardOpacity.blurOverlay,
                    shape: fieldShape
                )
            },
            border: {
                GeometryReader { geo in
                    DissolvingGradientBorder(
                        shape: fieldShape,
                        containerWidth: geo.size.width,
                        lineWidth: borderWidth,
                        cornerRadius: iconSize
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
        let size: CGFloat = 56

        VStack(spacing: size * 12 / 50) {
            AppInput(size: size, text: $text)
            AppInput(size: size * 7 / 10, text: $text)
            AppInput(size: size, text: $text)
                .disabled(true)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
    }
}
