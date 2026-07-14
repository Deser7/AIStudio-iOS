//
//  TextInputCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct TextInputCard: View {
    var characterLimit: Int = 400
    var placeholder = "Paste or write your text here..."
    var isFocused: FocusState<Bool>.Binding
    @Binding var text: String

    private var isOverLimit: Bool {
        text.count > characterLimit
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            TextField(
                "",
                text: $text,
                prompt: Text(key: placeholder)
                    .font(Typography.font(style: .regular16))
                    .foregroundColor(.white.opacity(0.3)),
                axis: .vertical
            )
            .lineLimit(6...50)
            .typography(style: .regular16)
            .foregroundColor(.white)
            .tint(.white)
            .focused(isFocused)
            .frame(maxWidth: .infinity, minHeight: 106, alignment: .topLeading)

            Text(verbatim: "\(text.count)/\(characterLimit)")
                .typography(style: .regular16)
                .foregroundColor(isOverLimit ? .error : .white.opacity(0.3))
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
}

#Preview("Empty") {
    TextInputCardPreview(text: "")
}

#Preview("Typing") {
    TextInputCardPreview(text: "Hi! Can you help me write")
}

#Preview("Over limit") {
    TextInputCardPreview(
        text: String(
            repeating: "I am writing to inform you that the project deadline has been moved to next Friday. Please adjust your schedule accordingly and let me ",
            count: 4
        )
    )
}

private struct TextInputCardPreview: View {
    @State private var text: String
    @FocusState private var isFocused: Bool

    init(text: String) {
        _text = State(initialValue: text)
    }

    var body: some View {
        TextInputCard(isFocused: $isFocused, text: $text)
            .padding(24)
            .background(Color.background)
    }
}
