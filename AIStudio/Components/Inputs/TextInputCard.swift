//
//  TextInputCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct TextInputCard: View {
    var characterLimit: Int = 400
    var isReadOnly: Bool = false
    var showsCharacterCounter: Bool = true
    var placeholder: String = "Paste or write your text here..."
    @Binding var text: String

    private var isOverLimit: Bool {
        !isReadOnly && text.count > characterLimit
    }

    private var secondaryColor: Color {
        .white.opacity(0.3)
    }

    private var editorLineLimit: ClosedRange<Int> {
        let visibleLines = max(Int(106 / 16), 1)
        return visibleLines...50
    }

    var body: some View {
        VStack(spacing: 0) {
            editor

            if showsCharacterCounter {
                characterCounter
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.top, 24)
        .padding([.horizontal, .bottom], 16)
        .frame(maxWidth: .infinity)
        .frame(height: 162, alignment: .top)
        .background(CardBlurBackground(opacity: 0.6))
        .overlay {
            if isOverLimit {
                AppShape.card
                    .strokeBorder(.error, lineWidth: 1)
            }
        }
    }

    @ViewBuilder
    private var editor: some View {
        if isReadOnly {
            Text(text.isEmpty ? placeholder : text)
                .typography(style: .regular16)
                .foregroundStyle(text.isEmpty ? AnyShapeStyle(secondaryColor) : AnyShapeStyle(.white))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .frame(height: 106, alignment: .top)
        } else {
            TextField(
                "",
                text: $text,
                prompt: Text(key: placeholder)
                    .font(Typography.font(style: .regular16))
                    .foregroundColor(secondaryColor),
                axis: .vertical
            )
            .lineLimit(editorLineLimit)
            .typography(style: .regular16)
            .foregroundColor(.white)
            .tint(.white)
            .frame(height: 106, alignment: .top)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var characterCounter: some View {
        Text("\(text.count)/\(characterLimit)")
            .typography(style: .regular16)
            .foregroundColor(isOverLimit ? .error : secondaryColor)
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
//            .background(Color.background)
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
