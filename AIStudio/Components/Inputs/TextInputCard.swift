//
//  TextInputCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct TextInputCard: View {
    var characterLimit: Int = 400
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var borderWidth: CGFloat {
        max(1, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var isOverLimit: Bool { text.count > 400 }

    private var secondaryColor: Color {
        .white.opacity(0.3)
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
        .background(CardBlurBackground(opacity: 0.6))
        .clipShape(AppShape.card)
        .overlay { errorBorder }
    }

    private var editor: some View {
        TextField(
            "",
            text: $text,
            prompt: Text("Paste or write your text here...")
                .font(Typography.font(style: .regular16))
                .foregroundColor(secondaryColor),
            axis: .vertical
        )
        .lineLimit(editorLineLimit)
        .typography(style: .regular16)
        .foregroundColor(.white)
        .tint(.white)
        .frame(height: editorHeight, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var characterCounter: some View {
        Text("\(text.count)/\(characterLimit)")
            .typography(style: .regular16)
            .foregroundColor(isOverLimit ? .error : secondaryColor)
    }

    @ViewBuilder
    private var errorBorder: some View {
        if isOverLimit {
            AppShape.card
                .strokeBorder(.error, lineWidth: borderWidth)
        }
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
