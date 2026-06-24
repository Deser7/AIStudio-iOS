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

#Preview("search") {
    SearchBarPreview()
        .padding(24)
        .background(Color.green)
}

#Preview("search — scaled") {
    SearchBarScaledPreview()
}

private struct SearchBarPreview: View {
    @State private var text = ""

    var body: some View {
        VStack(spacing: 24) {
            SearchBar(text: $text)

            SearchBar(size: 100, text: $text)

            SearchBar(text: $text)
                .disabled(true)
        }
    }
}

private struct SearchBarScaledPreview: View {
    @State private var text = ""

    var body: some View {
        GeometryReader { geo in
            let size = geo.size.width * 0.14

            SearchBar(size: size, text: $text)
                .padding(.horizontal, geo.size.width * 0.064)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
        }
    }
}
