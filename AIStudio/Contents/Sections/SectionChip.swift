//
//  SectionChip.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Чип секции (Figma «Sections», height = 33).
struct SectionChip: View {
    let title: String
    var height: CGFloat
    var isSelected: Bool
    let action: () -> Void

    /// Figma ref height = 33. Базовая единица — 16px (padding horizontal).
    private var spacing: CGFloat { height * 16 / 33 }
    private var fontSize: CGFloat { height * 14 / 33 }
    private var verticalPadding: CGFloat { height * 8 / 33 }
    private var cornerRadius: CGFloat { height * 24 / 33 }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var titleColor: Color {
        Color.white.opacity(isSelected ? 1 : 0.5)
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .typography(style: .regular, size: fontSize)
                .foregroundStyle(titleColor)
                .tracking(0)
                .padding(.horizontal, spacing)
                .padding(.vertical, verticalPadding)
                .frame(height: height)
                .background { chipBackground }
                .clipShape(shape)
        }
        .buttonStyle(.plain)
        .fixedSize(horizontal: true, vertical: false)
    }

    @ViewBuilder
    private var chipBackground: some View {
        if isSelected {
            AppGradient.main
        } else {
            BlurCardBackground(
                style: .compact,
                extent: height,
                blurRadius: blurRadius,
                cardOpacity: 0.6,
                shape: shape
            )
        }
    }
}

#Preview {
    let size: CGFloat = 33

    HStack(spacing: size * 8 / 33) {
        SectionChip(title: "Popular", height: size, isSelected: true, action: {})
        SectionChip(title: "Funny", height: size, isSelected: false, action: {})
    }
    .padding(24)
    .background(Color.green)
}
