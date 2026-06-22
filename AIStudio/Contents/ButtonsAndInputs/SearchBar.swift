//
//  SearchBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct SearchBar: View {
    static let defaultSize: CGFloat = 56

    private enum Layout {
        static let paddingRatio: CGFloat = 16 / 56
        static let gapRatio: CGFloat = 16 / 56
        static let fontSizeRatio: CGFloat = 16 / 56
        static let iconSizeRatio: CGFloat = 24 / 56
        static let cornerRadiusRatio: CGFloat = 24 / 56
        static let borderWidthRatio: CGFloat = 1 / 56
        static let backgroundOpacity: CGFloat = 0.6
        static let placeholderOpacity: CGFloat = 0.5
    }

    var placeholder: String = "Ask anything..."
    var size: CGFloat = SearchBar.defaultSize
    @Binding var text: String

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var padding: CGFloat { size * Layout.paddingRatio }
    private var gap: CGFloat { size * Layout.gapRatio }
    private var fontSize: CGFloat { size * Layout.fontSizeRatio }
    private var iconSize: CGFloat { size * Layout.iconSizeRatio }
    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var borderWidth: CGFloat {
        pixelAligned(max(size * Layout.borderWidthRatio, 1 / displayScale))
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private func pixelAligned(_ value: CGFloat) -> CGFloat {
        (value * displayScale).rounded() / displayScale
    }

    var body: some View {
        HStack(spacing: gap) {
            SearchIcon()
                .fill(Color.accent)
                .frame(width: iconSize, height: iconSize)

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(AppFont.font(weight: .regular, size: fontSize))
                    .foregroundColor(Color.accent.opacity(Layout.placeholderOpacity))
            )
            .font(AppFont.font(weight: .regular, size: fontSize))
            .foregroundColor(Color.accent)
            .tint(Color.accent)
        }
        .padding(padding)
        .frame(maxWidth: .infinity)
        .frame(height: size)
        .background {
            shape
                .fill(Color.card.opacity(Layout.backgroundOpacity))
        }
        .clipShape(shape)
        .overlay {
            shape
                .strokeBorder(Color.accent, lineWidth: borderWidth)
        }
        .opacity(isEnabled ? 1 : 0.6)
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
