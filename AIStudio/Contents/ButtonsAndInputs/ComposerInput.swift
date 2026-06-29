//
//  ComposerInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct ComposerInput: View {
    var placeholder: String = "How can I help you?"
    @Binding var text: String
    var onImport: () -> Void = {}
    var onMicrophone: () -> Void = {}
    var onSend: () -> Void = {}

    @State private var textHeight: CGFloat = 44
    @State private var containerWidth: CGFloat = 0

    private let minTextHeight: CGFloat = 44
    private var maxTextHeight: CGFloat {
        Typography.Style.regular16.lineHeight * 4 + 24
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 16) {
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .typography(style: .regular16)
                        .foregroundStyle(.price)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 8)
                        .allowsHitTesting(false)
                }

                TextEditor(text: $text)
                    .typography(style: .regular16)
                    .foregroundStyle(.white)
                    .frame(height: clampedTextHeight)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
            }
            .frame(maxWidth: .infinity)
            .background(widthReader)
            .overlay(alignment: .topLeading) {
                textMeasurer
            }

            if text.isEmpty {
                CircularIconButton(size: 40, icon: .photo, action: onImport)
                CircularIconButton(size: 40, icon: .micro, action: onMicrophone)
            } else {
                GradientIconButton(size: 40, icon: .generation, action: onSend)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 88)
        .background {
            GeometryReader { geo in
                BlurCardBackground(
                    style: .bar,
                    extent: geo.size.height,
                    blurRadius: AppSurface.blurRadius,
                    cardOpacity: 0.7,
                    shape: cardShape
                )
            }
        }
        .clipShape(cardShape)
        .appDisabledOpacity()
    }

    private var clampedTextHeight: CGFloat {
        min(max(minTextHeight, textHeight), maxTextHeight)
    }

    private var widthReader: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear { containerWidth = geo.size.width }
                .onChange(of: geo.size.width) { containerWidth = $0 }
        }
    }

    @ViewBuilder
    private var textMeasurer: some View {
        if containerWidth > 0 {
            Text(text.isEmpty ? " " : text)
                .typography(style: .regular16)
                .padding(.horizontal, 5)
                .padding(.vertical, 8)
                .frame(width: containerWidth, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear { updateTextHeight(geo.size.height) }
                            .onChange(of: geo.size.height) { updateTextHeight($0) }
                    }
                )
                .hidden()
                .allowsHitTesting(false)
        }
    }

    private func updateTextHeight(_ height: CGFloat) {
        guard abs(height - textHeight) > 0.5 else { return }
        textHeight = height
    }
}

#Preview("Editing") {
    ComposerInputPreview()
}

#Preview("With text") {
    ComposerInputPreview(text: "How can I help you?")
}

#Preview("Multi-line") {
    ComposerInputPreview(
        text: """
        Hi! Can you help me write a short welcome email for a new employee \
        joining our team?
        """
    )
}

#Preview("Word wrap") {
    ComposerInputPreview(
        text: "This is a long single paragraph that should wrap across multiple lines without explicit newlines just like ChatGPT composer does."
    )
}

private struct ComposerInputPreview: View {
    @State private var text: String

    init(text: String = "") {
        _text = State(initialValue: text)
    }

    var body: some View {
        ComposerInput(text: $text)
            .padding(24)
            .background(Color.background)
    }
}
