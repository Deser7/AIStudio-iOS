//
//  UserPrompt.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct UserPrompt: View {
    var text: String
    var image: Image?

    private var hasPhoto: Bool {
        image != nil
    }

    private var bubbleShape: UserPromptBubbleShape {
        UserPromptBubbleShape(
            cornerRadius: 16,
            sharpBottomTrailing: !hasPhoto
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: hasPhoto ? 9 : 0) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 16,
                            style: .continuous
                        )
                    )
            }

            messageText
        }
        .padding(contentPadding)
        .frame(width: 302, alignment: .leading)
        .background(AppGradient.main)
        .clipShape(bubbleShape)
    }

    private var messageText: some View {
        Text(text)
            .typography(style: .regular16)
            .foregroundStyle(Color.white)
            .tracking(0)
            .lineSpacing(0)
            .multilineTextAlignment(.leading)
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
            .foregroundStyle(Color.white)
            .lineLimit(1 ... 10)
            .padding(12)
            .background(Color.card)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            UserPrompt(text: text)

            UserPrompt(
                text: text,
                image: Image(systemName: "person.crop.rectangle.fill")
            )
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(Color.background)
    }
}
