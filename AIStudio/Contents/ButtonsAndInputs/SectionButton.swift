//
//  SectionButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct SectionButton: View {
    enum Style {
        case primary
        case secondary
    }

    let title: String
    var size: CGFloat
    var style: Style = .primary
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    private var fontSize: CGFloat { size * 16 / 50 }
    private var horizontalPadding: CGFloat { size * 12 / 50 }
    private var cornerRadius: CGFloat { size * 24 / 50 }

    private var titleColor: Color {
        isEnabled ? Color.accent : Color.black.opacity(0.3)
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.font(weight: .semiBold, size: fontSize))
                .foregroundStyle(titleColor)
                .padding(.horizontal, horizontalPadding)
                .frame(maxWidth: .infinity)
                .frame(height: size)
                .background { backgroundFill }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var backgroundFill: some View {
        if isEnabled, style == .primary {
            AppGradient.main
        } else {
            Color.card
        }
    }
}

#Preview {
    let size: CGFloat = 50

    VStack(spacing: size * 16 / 50) {
        SectionButton(title: "Label", size: size, style: .primary) {}
        SectionButton(title: "Label", size: size, style: .primary) {}
            .disabled(true)
        SectionButton(title: "Label", size: size * 56 / 50, style: .secondary) {}
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 24)
    .background(Color.background)
}
