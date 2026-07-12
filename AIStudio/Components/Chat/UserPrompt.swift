//
//  UserPrompt.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct UserPrompt: View {
    var text: String
    var images: [Image] = []
    var onCopy: (() -> Void)?
    var onEdit: (() -> Void)?

    private var hasPhoto: Bool {
        !images.isEmpty
    }

    private var hasText: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var bubbleShape: UserPromptBubbleShape {
        UserPromptBubbleShape(
            cornerRadius: 16,
            sharpBottomTrailing: !hasPhoto
        )
    }

    private let thumbnailColumns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: hasPhoto && hasText ? 9 : 0) {
            if hasPhoto {
                LazyVGrid(columns: thumbnailColumns, spacing: 8) {
                    ForEach(Array(images.enumerated()), id: \.offset) { _, image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 90)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 16,
                                    style: .continuous
                                )
                            )
                    }
                }
            }

            if hasText {
                messageText
            }
        }
        .padding(contentPadding)
        .frame(width: 302, alignment: .leading)
        .background(AppGradient.main)
        .clipShape(bubbleShape)
        .contentShape(bubbleShape)
        .contextMenu {
            if let onCopy, hasText {
                Button("Copy", systemImage: "doc.on.doc") {
                    onCopy()
                }
            }
            if let onEdit {
                Button("Edit", systemImage: "pencil") {
                    onEdit()
                }
            }
        }
    }

    private var messageText: some View {
        SelectableText(
            text,
            style: .regular16,
            color: .white,
            allowsLongPressSelection: false
        )
        .frame(
            maxWidth: hasPhoto ? .infinity : 270,
            alignment: .leading
        )
        .fixedSize(horizontal: false, vertical: true)
    }

    private var contentPadding: EdgeInsets {
        if hasPhoto {
            EdgeInsets(
                top: 4,
                leading: 14,
                bottom: 4,
                trailing: 14
            )
        } else {
            EdgeInsets(
                top: 16,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        }
    }
}

private struct UserPromptBubbleShape: Shape {
    var cornerRadius: CGFloat
    var sharpBottomTrailing: Bool

    func path(in rect: CGRect) -> Path {
        if sharpBottomTrailing {
            UnevenRoundedRectangle(
                topLeadingRadius: cornerRadius,
                bottomLeadingRadius: cornerRadius,
                bottomTrailingRadius: 0,
                topTrailingRadius: cornerRadius,
                style: .continuous
            ).path(in: rect)
        } else {
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous
            ).path(in: rect)
        }
    }
}

#Preview {
    UserPromptPreview()
}

private struct UserPromptPreview: View {
    @State private var text = "Hi! Can you help me write a short welcome email for a new employee joining our team?"

    var body: some View {
        VStack(alignment: .trailing, spacing: 24) {
            TextField(
                "Type a message",
                text: $text,
                axis: .vertical
            )
            .typography(style: .regular16)
            .foregroundStyle(.white)
            .lineLimit(1 ... 10)
            .padding(12)
            .background(.card)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            UserPrompt(
                text: text,
                onCopy: {},
                onEdit: {}
            )

            UserPrompt(
                text: text,
                images: [
                    Image(systemName: "person.crop.rectangle.fill"),
                    Image(systemName: "photo"),
                    Image(systemName: "camera.fill")
                ],
                onCopy: {},
                onEdit: {}
            )

            UserPrompt(
                text: "",
                images: [Image(systemName: "photo")],
                onCopy: {},
                onEdit: {}
            )
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(Color.background)
    }
}
