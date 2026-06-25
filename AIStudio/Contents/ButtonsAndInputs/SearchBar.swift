//
//  SearchBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct SearchBar: View {
    static let defaultSize: CGFloat = InputFieldMetrics.referenceSize

    var placeholder: String = "Ask anything..."
    var size: CGFloat = SearchBar.defaultSize
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var metrics: InputFieldMetrics { InputFieldMetrics(size: size) }
    private var borderWidth: CGFloat {
        max(size * 1 / InputFieldMetrics.referenceSize, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    var body: some View {
        TextFieldBar(
            placeholder: placeholder,
            size: size,
            text: $text,
            icon: {
                SearchIcon()
                    .fill(Color.accent)
                    .frame(width: metrics.iconSize, height: metrics.iconSize)
            },
            background: {
                metrics.shape
                    .fill(Color.card.opacity(AppSurface.CardOpacity.fill))
            },
            border: {
                metrics.shape
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
        let size = SearchBar.defaultSize

        VStack(spacing: size * 0.24) {
            SearchBar(size: size, text: $text)
            SearchBar(size: size * 0.7, text: $text)
            SearchBar(size: size, text: $text)
                .disabled(true)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
    }
}
