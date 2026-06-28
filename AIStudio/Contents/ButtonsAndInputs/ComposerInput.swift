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
    /// Загрузка изображения (Addendum spinner).
    case imageLoading
    /// Ожидание ответа AI (Addendum spinner + текст).
    case generating
}

struct ComposerInput: View {
    private enum Layout {
        static let placeholderRed: CGFloat = 96 / 255
    }

    var placeholder: String = "How can I help you?"
    var height: CGFloat
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

    @Environment(\.displayScale) private var displayScale

    private var spacing: CGFloat { height * 2 / 11 }
    private var sectionSpacing: CGFloat { height * 3 / 11 }
    private var buttonSize: CGFloat { height * 5 / 11 }
    private var addendumSize: CGFloat { height * 25 / 22 }
    private var blurRadius: CGFloat { height * AppSurface.blurRadius / 88 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: sectionSpacing, style: .continuous)
    }

    private var placeholderColor: Color {
        Color(
            red: Layout.placeholderRed,
            green: Layout.placeholderRed,
            blue: Layout.placeholderRed
        )
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
        switch state {
        case .generating:
            height * 229 / 88
        default:
            height
        }
    }

    private var showsGeneratingContent: Bool {
        state == .generating
    }

    var body: some View {
        VStack(alignment: .leading, spacing: sectionSpacing) {
            attachmentSection

            if showsGeneratingContent {
                generatingSection
            }

            HStack(alignment: .bottom, spacing: spacing) {
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
        .padding(.horizontal, spacing)
        .padding(.vertical, sectionSpacing)
        .frame(maxWidth: .infinity, minHeight: containerMinHeight, alignment: .top)
        .background { background }
        .clipShape(shape)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var generatingSection: some View {
        Addendum(diameter: addendumSize, content: .loading)

        Spacer(minLength: 0)
    }

    @ViewBuilder
    private var attachmentSection: some View {
        if state == .imageLoading {
            Addendum(diameter: addendumSize, content: .loading)
        } else if let attachedImage {
            Addendum(
                diameter: addendumSize,
                content: .photo(attachedImage, onClose: removeAttachment)
            )
        }
    }

    private var textInput: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .font(Typography.font(style: .regular, size: spacing))
                .foregroundColor(placeholderColor),
            axis: .vertical
        )
        .lineLimit(1...10)
        .typography(style: .regular, size: spacing)
        .foregroundColor(Color.white)
        .tint(Color.white)
        .disabled(isTextInputDisabled)
    }

    @ViewBuilder
    private var buttonSection: some View {
        if showsSendButton {
            GradientIconButton(diameter: buttonSize, icon: .generation, action: handleSend)
        } else {
            HStack(spacing: spacing) {
                CircularIconButton(diameter: buttonSize, icon: .photo, action: handleImport)
                CircularIconButton(diameter: buttonSize, icon: .micro, action: handleMicrophone)
            }
        }
    }

    private var voiceRow: some View {
        HStack(spacing: spacing) {
            CircularIconButton(diameter: buttonSize, icon: .cross, action: handleVoiceCancel)

            AudioWaveform(
                progress: voiceProgress,
                height: buttonSize
            )
            .frame(maxWidth: .infinity)

            GradientIconButton(diameter: buttonSize, icon: .done, action: handleVoiceConfirm)
        }
    }

    @ViewBuilder
    private var background: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .bar,
                extent: geo.size.height,
                blurRadius: blurRadius,
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

// MARK: - Previews

#Preview {
    ComposerInputPreview()
}

private struct ComposerInputPreview: View {
    @State private var state = ComposerInputState.editing
    @State private var text = ""
    @State private var attachedImage: Image?
    @State private var voiceProgress: CGFloat = 0

    var body: some View {
        ComposerInput(height: 88,
            state: $state,
            voiceProgress: $voiceProgress,
            text: $text,
            attachedImage: $attachedImage,
            onImport: simulateImageImport,
            onSend: simulateGenerating
        )
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
        .task(id: state) {
            guard state == .voiceRecording else { return }

            voiceProgress = 0
            while state == .voiceRecording, voiceProgress < 1 {
                try? await Task.sleep(for: .milliseconds(120))
                voiceProgress = min(voiceProgress + 0.03, 1)
            }
        }
    }

    private func simulateImageImport() {
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            await MainActor.run {
                attachedImage = Image(systemName: "person.crop.rectangle.fill")
                state = .editing
            }
        }
    }

    private func simulateGenerating() {
        Task {
            try? await Task.sleep(for: .seconds(2))
            await MainActor.run {
                state = .editing
            }
        }
    }
}
