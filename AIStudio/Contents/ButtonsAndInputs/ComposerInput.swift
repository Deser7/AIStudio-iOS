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
    static let defaultSize: CGFloat = 88

    private enum Layout {
        static let referenceMinHeight: CGFloat = 88
        static let referenceGeneratingHeight: CGFloat = 229
        static let horizontalPaddingRatio: CGFloat = 16 / 88
        static let verticalPaddingRatio: CGFloat = 24 / 88
        static let sectionGapRatio: CGFloat = 24 / 88
        static let buttonGapRatio: CGFloat = 16 / 88
        static let buttonSizeRatio: CGFloat = 40 / 88
        static let cornerRadiusRatio: CGFloat = 24 / 88
        static let fontSizeRatio: CGFloat = 16 / 88
        static let addendumSizeRatio: CGFloat = 100 / 88
        static let waveformHeightRatio: CGFloat = 40 / 88
        static let placeholderRed: CGFloat = 96 / 255
    }

    var placeholder: String = "How can I help you?"
    var size: CGFloat = ComposerInput.defaultSize
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

    private var horizontalPadding: CGFloat { size * Layout.horizontalPaddingRatio }
    private var verticalPadding: CGFloat { size * Layout.verticalPaddingRatio }
    private var sectionGap: CGFloat { size * Layout.sectionGapRatio }
    private var buttonGap: CGFloat { size * Layout.buttonGapRatio }
    private var buttonSize: CGFloat { size * Layout.buttonSizeRatio }
    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var fontSize: CGFloat { size * Layout.fontSizeRatio }
    private var addendumSize: CGFloat { size * Layout.addendumSizeRatio }
    private var waveformHeight: CGFloat { size * Layout.waveformHeightRatio }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
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
            size * Layout.referenceGeneratingHeight / Layout.referenceMinHeight
        default:
            size
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: sectionGap) {
            attachmentSection

            if state == .generating {
                AddendumLoader(size: addendumSize)

                Spacer(minLength: 0)
            }

            HStack(alignment: .bottom, spacing: buttonGap) {
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
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .frame(maxWidth: .infinity, minHeight: containerMinHeight, alignment: .top)
        .background { background }
        .clipShape(shape)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var attachmentSection: some View {
        if state == .imageLoading {
            AddendumLoader(size: addendumSize)
        } else if let attachedImage {
            Addendum(
                size: addendumSize,
                content: .photo(attachedImage, onClose: removeAttachment)
            )
        }
    }

    private var textInput: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .font(AppFont.font(weight: .regular, size: fontSize))
                .foregroundColor(placeholderColor),
            axis: .vertical
        )
        .lineLimit(1...10)
        .font(AppFont.font(weight: .regular, size: fontSize))
        .foregroundColor(Color.accent)
        .tint(Color.accent)
        .disabled(isTextInputDisabled)
    }

    @ViewBuilder
    private var buttonSection: some View {
        if showsSendButton {
            GradientIconButton(size: buttonSize, icon: .generation, action: handleSend)
        } else {
            HStack(spacing: buttonGap) {
                CircularIconButton(size: buttonSize, icon: .photo, action: handleImport)
                CircularIconButton(size: buttonSize, icon: .micro, action: handleMicrophone)
            }
        }
    }

    private var voiceRow: some View {
        HStack(spacing: buttonGap) {
            CircularIconButton(size: buttonSize, icon: .cross, action: handleVoiceCancel)

            AudioWaveform(
                progress: voiceProgress,
                height: waveformHeight
            )
            .frame(maxWidth: .infinity)

            GradientIconButton(size: buttonSize, icon: .done, action: handleVoiceConfirm)
        }
    }

    @ViewBuilder
    private var background: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .bar,
                size: geo.size.height,
                blurRadius: blurRadius,
                cardOpacity: AppSurface.CardOpacity.blurOverlay,
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

#Preview("composer") {
    ComposerInputPreview()
        .padding(24)
        .background(Color.background)
}

#Preview("composer — scaled") {
    ComposerInputScaledPreview()
}

private struct ComposerInputPreview: View {
    @State private var state = ComposerInputState.editing
    @State private var text = ""
    @State private var attachedImage: Image?
    @State private var voiceProgress: CGFloat = 0

    var body: some View {
        ComposerInput(
            state: $state,
            voiceProgress: $voiceProgress,
            text: $text,
            attachedImage: $attachedImage,
            onImport: simulateImageImport,
            onSend: simulateGenerating
        )
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

private struct ComposerInputScaledPreview: View {
    @State private var state = ComposerInputState.editing
    @State private var text = ""
    @State private var attachedImage: Image?
    @State private var voiceProgress: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            let size = geo.size.width * 0.22

            ComposerInput(
                size: size,
                state: $state,
                voiceProgress: $voiceProgress,
                text: $text,
                attachedImage: $attachedImage,
                onImport: {}
            )
            .padding(.horizontal, geo.size.width * 0.064)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}
