//
//  ComposerInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 29.06.2026.
//

import SwiftUI

struct ComposerInput: View {
    var mode: ComposerInputMode = .text
    var placeholder = "How can I help you?"
    var autofocus = false
    var attachments: [ComposerAttachmentPreview] = []
    var maxAttachments = 10
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    @Binding var isImportMenuExpanded: Bool
    let onPhotos: () -> Void
    let onFiles: () -> Void
    let onRemoveAttachment: (UUID) -> Void
    let onMicro: () -> Void
    let onSend: () -> Void
    let onCancelRecording: () -> Void
    let onConfirmRecording: () -> Void

    private let buttonSize: CGFloat = 40
    private let addendumSize: CGFloat = 100

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
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !attachments.isEmpty
    }

    private var canAddMoreAttachments: Bool {
        attachments.count < maxAttachments
    }

    private var minHeight: CGFloat {
        switch mode {
        case .text: 88
        case .recording: 131
        case .attachment: 229
        }
    }

    var body: some View {
        Group {
            switch mode {
            case .text:
                textLayout
            case let .recording(progress):
                recordingLayout(progress: progress)
            case let .attachment(isLoading):
                attachmentLayout(isLoading: isLoading)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 16)
        .frame(minHeight: minHeight)
        .frame(maxWidth: .infinity)
        .background {
            CardBlurBackground(shape: shape, opacity: 0.7)
                .ignoresSafeArea(edges: .bottom)
        }
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
        .composerImportPopover(
            isExpanded: $isImportMenuExpanded,
            trailingInset: importMenuTrailingInset,
            onGallery: onPhotos,
            onFiles: onFiles
        )
        .onChange(of: showsSend) { _, showsSend in
            guard showsSend else { return }
            isImportMenuExpanded = false
        }
    }

    private var importMenuTrailingInset: CGFloat {
        buttonSize * 2 + 16
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

    private func attachmentLayout(isLoading: Bool) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 12) {
                    ForEach(attachments) { item in
                        Addendum(
                            size: addendumSize,
                            content: .photo(item.image) {
                                onRemoveAttachment(item.id)
                            }
                        )
                    }

                    if isLoading {
                        Addendum(size: addendumSize, content: .loading)
                    } else if canAddMoreAttachments {
                        Button(action: onPhotos) {
                            Addendum(size: addendumSize, content: .addLabel)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

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
            prompt: Text(key: placeholder)
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
                ComposerImportMenu(
                    isExpanded: $isImportMenuExpanded,
                    onPhotos: onPhotos,
                    onFiles: onFiles
                ) {
                    CircularIconButton(size: buttonSize, icon: .photo)
                }
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
    @State private var attachments: [ComposerAttachmentPreview]
    @State private var isImportMenuExpanded = false
    @Binding var text: String
    @FocusState private var isFocused: Bool

    init(
        mode: ComposerInputMode = .text,
        attachments: [ComposerAttachmentPreview] = [],
        text: Binding<String>
    ) {
        _mode = State(initialValue: mode)
        _attachments = State(initialValue: attachments)
        _text = text
    }

    var body: some View {
        ComposerInput(
            mode: mode,
            attachments: attachments,
            text: $text,
            isFocused: $isFocused,
            isImportMenuExpanded: $isImportMenuExpanded,
            onPhotos: {
                mode = .attachment(isLoading: false)
                attachments = [
                    ComposerAttachmentPreview(
                        id: UUID(),
                        image: Image(systemName: "photo")
                    )
                ]
            },
            onFiles: {
                mode = .attachment(isLoading: false)
                attachments = [
                    ComposerAttachmentPreview(
                        id: UUID(),
                        image: Image(systemName: "doc")
                    )
                ]
            },
            onRemoveAttachment: { id in
                attachments.removeAll { $0.id == id }
                if attachments.isEmpty {
                    mode = .text
                }
            },
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
