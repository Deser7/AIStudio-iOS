//
//  UserPrompt.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Пузырь запроса пользователя (Figma «Prompt»). Высота — hug по тексту.
struct UserPrompt: View {
    var text: String
    var image: Image?
    var size: CGFloat

    /// Figma ref width = 302 (пузырь). Текстовая область = 270 = 302 − 16 − 16.
    private var spacing: CGFloat { size * 16 / 302 }
    private var fontSize: CGFloat { spacing }
    private var cornerRadius: CGFloat { spacing }
    private var textWidth: CGFloat { size * 270 / 302 }
    private var imageSize: CGFloat { size * 100 / 302 }
    private var imageCornerRadius: CGFloat { spacing }
    private var photoContentSpacing: CGFloat { size * 9 / 302 }
    private var compactVerticalPadding: CGFloat { size * 4 / 302 }
    private var compactHorizontalPadding: CGFloat { size * 14 / 302 }
    private var textLineHeight: CGFloat { fontSize }

    private var hasPhoto: Bool {
        image != nil
    }

    private var bubbleShape: UserPromptBubbleShape {
        UserPromptBubbleShape(
            cornerRadius: cornerRadius,
            sharpBottomTrailing: !hasPhoto
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: hasPhoto ? photoContentSpacing : 0) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: imageCornerRadius,
                            style: .continuous
                        )
                    )
            }

            messageText
        }
        .padding(contentPadding)
        .frame(width: size, alignment: .leading)
        .background(AppGradient.main)
        .clipShape(bubbleShape)
    }

    private var messageText: some View {
        Text(text)
            .font(AppFont.font(weight: .regular, size: fontSize))
            .foregroundStyle(Color.white)
            .tracking(0)
            .lineSpacing(textLineHeight - fontSize)
            .multilineTextAlignment(.leading)
            .frame(
                maxWidth: hasPhoto ? .infinity : textWidth,
                alignment: .leading
            )
            .fixedSize(horizontal: false, vertical: true)
    }

    private var contentPadding: EdgeInsets {
        if hasPhoto {
            EdgeInsets(
                top: compactVerticalPadding,
                leading: compactHorizontalPadding,
                bottom: compactVerticalPadding,
                trailing: compactHorizontalPadding
            )
        } else {
            EdgeInsets(
                top: spacing,
                leading: spacing,
                bottom: spacing,
                trailing: spacing
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

    private let size: CGFloat = 302

    var body: some View {
        VStack(alignment: .trailing, spacing: size * 24 / 302) {
            TextField(
                "Type a message",
                text: $text,
                axis: .vertical
            )
            .font(AppFont.font(weight: .regular, size: 16))
            .foregroundStyle(Color.white)
            .lineLimit(1 ... 10)
            .padding(12)
            .background(Color.card)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            UserPrompt(text: text, size: size)

            UserPrompt(
                text: text,
                image: Image(systemName: "person.crop.rectangle.fill"),
                size: size
            )
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(Color.background)
    }
}
