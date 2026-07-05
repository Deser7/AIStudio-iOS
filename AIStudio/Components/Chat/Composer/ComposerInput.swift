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
    case attachmentLoading
}

struct ComposerInput: View {
    var mode: ComposerInputMode = .text
    var placeholder = "How can I help you?"
    var autofocus = false
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    let onImport: () -> Void
    let onMicro: () -> Void
    let onSend: () -> Void
    let onCancelRecording: () -> Void
    let onConfirmRecording: () -> Void

    private let buttonSize: CGFloat = 40

    private var shape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(
            topLeadingRadius: AppShape.cornerRadius,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: AppShape.cornerRadius,
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
        case .attachmentLoading: 229
        }
    }

    var body: some View {
        Group {
            switch mode {
            case .text:
                textLayout
            case let .recording(progress):
                recordingLayout(progress: progress)
            case .attachmentLoading:
                attachmentLayout
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(minHeight: minHeight)
        .background(CardBlurBackground(shape: shape, opacity: 1))
        .clipShape(shape)
        .onAppear {
            guard autofocus else { return }
            isFocused.wrappedValue = true
        }
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

    private var attachmentLayout: some View {
        VStack(alignment: .leading, spacing: 16) {
            Addendum(size: 100, content: .loading)

            HStack(alignment: .center, spacing: 16) {
                textField
                if showsSend {
                    GradientIconButton(size: buttonSize, icon: .generation, action: onSend)
                }
            }
        }
    }

    private var textField: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .font(Typography.font(style: .regular16))
                .foregroundColor(.price),
            axis: .vertical
        )
        .lineLimit(1...6)
        .typography(style: .regular16)
        .foregroundColor(.white)
        .tint(.white)
        .focused(isFocused)
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
}

#Preview() {
    ComposerInputPreview()
}

private struct ComposerInputPreviewContainer: View {
    @State private var mode: ComposerInputMode
    @Binding var text: String
    @FocusState private var isFocused: Bool

    init(mode: ComposerInputMode = .text, text: Binding<String>) {
        _mode = State(initialValue: mode)
        _text = text
    }

    var body: some View {
        ComposerInput(
            mode: mode,
            text: $text,
            isFocused: $isFocused,
            onImport: { mode = .attachmentLoading },
            onMicro: { mode = .recording(progress: 0.45) },
            onSend: {},
            onCancelRecording: { mode = .text },
            onConfirmRecording: { mode = .text }
        )
        .background(Color.background)
    }
}

private struct ComposerInputPreview: View {
    @State private var text = ""

    var body: some View {
        ComposerInputPreviewContainer(text: $text)
    }
}
