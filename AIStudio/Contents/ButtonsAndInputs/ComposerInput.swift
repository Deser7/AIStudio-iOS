//
//  ComposerInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 29.06.2026.
//

import SwiftUI

enum ComposerInputMode: Equatable {
    case text
    case recording(progress: CGFloat)
}

struct ComposerInput: View {
    var mode: ComposerInputMode = .text
    @Binding var text: String
    let onImport: () -> Void
    let onMicro: () -> Void
    let onSend: () -> Void
    let onCancelRecording: () -> Void
    let onConfirmRecording: () -> Void

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

    private var minHeight: CGFloat {
        switch mode {
        case .text: 88
        case .recording: 131
        }
    }

    var body: some View {
        Group {
            switch mode {
            case .text:
                textLayout
            case let .recording(progress):
                recordingLayout(progress: progress)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(minHeight: minHeight)
        .background { background }
        .clipShape(shape)
        .appDisabledOpacity()
    }

    private var textLayout: some View {
        HStack(alignment: .center, spacing: 16) {
            textField
            trailingActions
        }
    }

    private func recordingLayout(progress: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            textField
            ComposerRecordingControls(
                progress: progress,
                onCancel: onCancelRecording,
                onConfirm: onConfirmRecording
            )
        }
    }

    private var textField: some View {
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

#Preview("Recording") {
    ComposerInputRecordingPreview()
}

private struct ComposerInputPreviewContainer: View {
    @State private var mode: ComposerInputMode
    @Binding var text: String

    init(mode: ComposerInputMode = .text, text: Binding<String>) {
        _mode = State(initialValue: mode)
        _text = text
    }

    var body: some View {
        ComposerInput(
            mode: mode,
            text: $text,
            onImport: {},
            onMicro: { mode = .recording(progress: 0.45) },
            onSend: {},
            onCancelRecording: { mode = .text },
            onConfirmRecording: { mode = .text }
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

private struct ComposerInputRecordingPreview: View {
    @State private var text = ""

    var body: some View {
        ComposerInputPreviewContainer(
            mode: .recording(progress: 0.45),
            text: $text
        )
    }
}
