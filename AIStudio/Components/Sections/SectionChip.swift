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
    var isSelected: Bool
    let action: () -> Void

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    private var titleColor: Color {
        .white.opacity(isSelected ? 1 : 0.5)
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .typography(style: .regular14)
                .foregroundStyle(titleColor)
                .tracking(0)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(height: 33)
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
                extent: 33,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.6,
                shape: shape
            )
        }
    }
}

#Preview {
    HStack(spacing: 8) {
        SectionChip(title: "Popular", isSelected: true, action: {})
        SectionChip(title: "Funny", isSelected: false, action: {})
    }
    .padding(24)
    .background(.green)
}
