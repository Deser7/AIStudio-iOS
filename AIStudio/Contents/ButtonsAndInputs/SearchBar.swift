//
//  SearchBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct SearchBar: View {
    var placeholder: String = "Ask anything..."
    var size: CGFloat
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var iconSize: CGFloat { size * 3 / 7 }
    private var borderWidth: CGFloat {
        max(size * 1 / 56, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var fieldShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: iconSize, style: .continuous)
    }

    var body: some View {
        TextFieldBar(
            placeholder: placeholder,
            size: size,
            text: $text,
            icon: {
                SearchIcon()
                    .fill(Color.accent)
                    .frame(width: iconSize, height: iconSize)
            },
            background: {
                fieldShape
                    .fill(Color.card.opacity(AppSurface.CardOpacity.fill))
            },
            border: {
                fieldShape
                    .strokeBorder(Color.accent, lineWidth: borderWidth)
            }
        )
    }
}

#Preview {
    SearchBarPreview()
}

private struct SearchBarPreview: View {
    @State private var text = ""

    var body: some View {
        let size: CGFloat = 56

        VStack(spacing: size * 12 / 50) {
            SearchBar(size: size, text: $text)
            SearchBar(size: size * 7 / 10, text: $text)
            SearchBar(size: size, text: $text)
                .disabled(true)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
    }
}
