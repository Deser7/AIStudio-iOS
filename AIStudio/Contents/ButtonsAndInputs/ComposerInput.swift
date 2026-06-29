//
//  ComposerInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

enum ComposerInputState: Equatable {
    case editing
    case voiceRecording
    case imageLoading
    case generating
}

struct ComposerInput: View {
    var placeholder: String = "How can I help you?"
    @Binding var state: ComposerInputState
    @Binding var voiceProgress: CGFloat
    @Binding var text: String
    @Binding var attachedImage: Image?

    var onImport: () -> Void = {}
    var onMicrophone: () -> Void = {}
    var onSend: () -> Void = {}
    var onVoiceCancel: () -> Void = {}
    var onVoiceConfirm: () -> Void = {}
    var onImageRemove: () -> Void = {}

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    private var showsVoiceRow: Bool {
        state == .voiceRecording
    }

    private var showsSendButton: Bool {
        state == .generating || (state == .editing && !text.isEmpty)
    }

    private var showsSideButtons: Bool {
        state == .editing
    }

    private var isTextInputDisabled: Bool {
        state == .generating || state == .imageLoading
    }

    private var containerMinHeight: CGFloat {
        state == .generating ? 229 : 88
    }

    private var showsGeneratingContent: Bool {
        state == .generating
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            attachmentSection

            if showsGeneratingContent {
                generatingSection
            }

            HStack(alignment: .center, spacing: 16) {
                textInput
                    .frame(maxWidth: .infinity, alignment: .leading)

                if showsSideButtons {
                    buttonSection
                }
            }

            if showsVoiceRow {
                voiceRow
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity, minHeight: containerMinHeight, alignment: .top)
        .background { background }
        .clipShape(shape)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var generatingSection: some View {
        Addendum(diameter: 100, content: .loading)

        Spacer(minLength: 0)
    }

    @ViewBuilder
    private var attachmentSection: some View {
        if state == .imageLoading {
            Addendum(diameter: 100, content: .loading)
        } else if let attachedImage {
            Addendum(
                diameter: 100,
                content: .photo(attachedImage, onClose: removeAttachment)
            )
        }
    }

    private var textInput: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .font(Typography.font(style: .regular16))
                .foregroundColor(.price),
            axis: .vertical
        )
        .lineLimit(1...10)
        .typography(style: .regular16)
        .foregroundColor(Color.white)
        .tint(Color.white)
        .disabled(isTextInputDisabled)
    }

    @ViewBuilder
    private var buttonSection: some View {
        if showsSendButton {
            GradientIconButton(size: 40, icon: .generation, action: handleSend)
        } else {
            HStack(spacing: 16) {
                CircularIconButton(size: 40, icon: .photo, action: handleImport)
                CircularIconButton(size: 40, icon: .micro, action: handleMicrophone)
            }
        }
    }

    private var voiceRow: some View {
        HStack(spacing: 16) {
            CircularIconButton(size: 40, icon: .cross, action: handleVoiceCancel)

            AudioWaveform(progress: voiceProgress)
            .frame(maxWidth: .infinity)

            GradientIconButton(size: 40, icon: .done, action: handleVoiceConfirm)
        }
    }

    @ViewBuilder
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

    private func handleImport() {
        state = .imageLoading
        onImport()
    }

    private func handleMicrophone() {
        state = .voiceRecording
        onMicrophone()
    }

    private func handleSend() {
        state = .generating
        onSend()
    }

    private func handleVoiceCancel() {
        voiceProgress = 0
        state = .editing
        onVoiceCancel()
    }

    private func handleVoiceConfirm() {
        state = .editing
        onVoiceConfirm()
    }

    private func removeAttachment() {
        attachedImage = nil
        onImageRemove()
    }
}

#Preview("Editing") {
    ComposerInputPreview()
}

#Preview("With text") {
    ComposerInputPreview(text: "How can I help you?")
}

#Preview("Voice") {
    ComposerInputPreview(state: .voiceRecording, voiceProgress: 0.42)
}

#Preview("Generating") {
    ComposerInputPreview(state: .generating)
}

#Preview("With photo") {
    ComposerInputPreview(
        attachedImage: Image(systemName: "person.crop.rectangle.fill")
    )
}

private struct ComposerInputPreview: View {
    @State private var state: ComposerInputState
    @State private var text: String
    @State private var voiceProgress: CGFloat
    @State private var attachedImage: Image?

    init(
        state: ComposerInputState = .editing,
        text: String = "",
        voiceProgress: CGFloat = 0,
        attachedImage: Image? = nil
    ) {
        _state = State(initialValue: state)
        _text = State(initialValue: text)
        _voiceProgress = State(initialValue: voiceProgress)
        _attachedImage = State(initialValue: attachedImage)
    }

    var body: some View {
        ComposerInput(
            state: $state,
            voiceProgress: $voiceProgress,
            text: $text,
            attachedImage: $attachedImage
        )
        .padding(24)
        .background(Color.background)
    }
}
