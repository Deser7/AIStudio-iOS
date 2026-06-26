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
    var size: CGFloat
    var isSelected: Bool
    let action: () -> Void

    /// Figma ref height = 33. Базовая единица — 16px (padding horizontal).
    private var spacing: CGFloat { size * 16 / 33 }
    private var fontSize: CGFloat { size * 14 / 33 }
    private var verticalPadding: CGFloat { size * 8 / 33 }
    private var cornerRadius: CGFloat { size * 24 / 33 }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var titleColor: Color {
        Color.accent.opacity(
            isSelected
                ? 1
                : AppSurface.Interaction.notificationSubtitleOpacity
        )
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .typography(Typography.regular(size: fontSize))
                .foregroundStyle(titleColor)
                .tracking(0)
                .padding(.horizontal, spacing)
                .padding(.vertical, verticalPadding)
                .frame(height: size)
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
                size: size,
                blurRadius: blurRadius,
                cardOpacity: AppSurface.CardOpacity.fill,
                shape: shape
            )
        }
    }
}

#Preview {
    let size: CGFloat = 33

    HStack(spacing: size * 8 / 33) {
        SectionChip(title: "Popular", size: size, isSelected: true, action: {})
        SectionChip(title: "Funny", size: size, isSelected: false, action: {})
    }
    .padding(24)
    .background(Color.green)
}
