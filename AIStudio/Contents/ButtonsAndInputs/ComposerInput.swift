//
//  ComposerInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 29.06.2026.
//

import SwiftUI

struct ComposerInput: View {
    @Binding var text: String
    let onImport: () -> Void
    let onMicro: () -> Void
    let onSend: () -> Void

    private let cornerRadius: CGFloat = 24
    private let buttonSize: CGFloat = 40

    private var shape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(
            topLeadingRadius: cornerRadius,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: cornerRadius,
            style: .continuous
        )
    }

    private var showsSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            TextField(
                "",
                text: $text,
                prompt: Text("How can I help you?")
                    .font(Typography.font(style: .regular16))
                    .foregroundColor(.price),
                axis: .vertical
            )
            .lineLimit(1...6)
            .typography(style: .regular16)
            .foregroundColor(Color.white)
            .tint(Color.white)
            .frame(maxWidth: .infinity, alignment: .leading)

            trailingActions
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(minHeight: 88)
        .background { background }
        .clipShape(shape)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var trailingActions: some View {
        if showsSend {
            GradientIconButton(size: buttonSize, icon: .generation, action: onSend)
        } else {
            HStack(spacing: 16) {
                CircularIconButton(size: buttonSize, icon: .photo, action: onImport)
                CircularIconButton(size: buttonSize, icon: .micro, action: onMicro)
            }
        }
    }

    private var background: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .bar,
                extent: geo.size.height,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.7,
                shape: shape
            )
        }
    }
}

#Preview("Empty") {
    ComposerInputEmptyPreview()
}

#Preview("Typing") {
    ComposerInputTypingPreview()
}

#Preview("Multiline") {
    ComposerInputMultilinePreview()
}

private struct ComposerInputPreviewContainer: View {
    @Binding var text: String

    var body: some View {
        ComposerInput(
            text: $text,
            onImport: {},
            onMicro: {},
            onSend: {}
        )
        .background(Color.background)
    }
}

private struct ComposerInputEmptyPreview: View {
    @State private var text = ""

    var body: some View {
        ComposerInputPreviewContainer(text: $text)
    }
}

private struct ComposerInputTypingPreview: View {
    @State private var text = "Hi! Can you help me write"

    var body: some View {
        ComposerInputPreviewContainer(text: $text)
    }
}

private struct ComposerInputMultilinePreview: View {
    @State private var text =
        "Hi! Can you help me write a short welcome email for a new employee joining our team?"

    var body: some View {
        ComposerInputPreviewContainer(text: $text)
    }
}
