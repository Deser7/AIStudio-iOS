//
//  TextInputCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct TextInputCard: View {
    var placeholder: String = "Paste or write your text here..."
    var characterLimit: Int = 400
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var borderWidth: CGFloat {
        max(1, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    private var isOverLimit: Bool { text.count > characterLimit }

    private var secondaryColor: Color {
        Color.white.opacity(0.3)
    }

    private var editorHeight: CGFloat { 106 }

    private var editorLineLimit: ClosedRange<Int> {
        let visibleLines = max(Int(editorHeight / 16), 1)
        return visibleLines...max(visibleLines, 50)
    }

    var body: some View {
        VStack(spacing: 0) {
            editor

            characterCounter
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.top, 24)
        .padding([.horizontal, .bottom], 16)
        .frame(width: 342, height: 162, alignment: .top)
        .background { cardBackground }
        .clipShape(shape)
        .overlay { errorBorder }
    }

    private var editor: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .font(Typography.font(style: .regular, size: 16))
                .foregroundColor(secondaryColor),
            axis: .vertical
        )
        .lineLimit(editorLineLimit)
        .typography(style: .regular, size: 16)
        .foregroundColor(Color.white)
        .tint(Color.white)
        .frame(height: editorHeight, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var characterCounter: some View {
        Text("\(text.count)/\(characterLimit)")
            .typography(style: .regular, size: 16)
            .foregroundColor(isOverLimit ? Color.error : secondaryColor)
    }

    @ViewBuilder
    private var errorBorder: some View {
        if isOverLimit {
            shape
                .strokeBorder(Color.error, lineWidth: borderWidth)
        }
    }

    private var cardBackground: some View {
        BlurCardBackground(
            style: .compact,
            extent: 162,
            blurRadius: AppSurface.blurRadius,
            cardOpacity: 0.6,
            shape: shape
        )
    }
}

#Preview("Empty") {
    TextInputCardEmptyPreview()
}

#Preview("Typing") {
    TextInputCardTypingPreview()
}

#Preview("Over limit") {
    TextInputCardOverLimitPreview()
}

private struct TextInputCardPreviewContainer: View {
    @Binding var text: String

    var body: some View {
        TextInputCard(text: $text)
            .padding(24)
            .background(Color.background)
    }
}

private struct TextInputCardEmptyPreview: View {
    @State private var text = ""

    var body: some View {
        TextInputCardPreviewContainer(text: $text)
    }
}

private struct TextInputCardTypingPreview: View {
    @State private var text = "Hi! Can you help me write"

    var body: some View {
        TextInputCardPreviewContainer(text: $text)
    }
}

private struct TextInputCardOverLimitPreview: View {
    @State private var text = String(
        repeating: "I am writing to inform you that the project deadline has been moved to next Friday. Please adjust your schedule accordingly and let me ",
        count: 4
    )

    var body: some View {
        TextInputCardPreviewContainer(text: $text)
    }
}
