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

    static let defaultSize: CGFloat = 50

    private enum Layout {
        static let cornerRadiusRatio: CGFloat = 24 / 50
        static let paddingRatio: CGFloat = 12 / 50
        static let fontSizeRatio: CGFloat = 16 / 50
    }

    let title: String
    var size: CGFloat = SectionButton.defaultSize
    var style: Style = .primary
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var horizontalPadding: CGFloat { size * Layout.paddingRatio }
    private var fontSize: CGFloat { size * Layout.fontSizeRatio }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.font(weight: .semiBold, size: fontSize))
                .foregroundStyle(foregroundColor)
                .padding(.horizontal, horizontalPadding)
                .frame(maxWidth: .infinity)
                .frame(height: size)
                .background { background }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var background: some View {
        if isEnabled, style == .primary {
            LinearGradient(
                colors: [.aiBlue, .aiPink],
                startPoint: .leading,
                endPoint: .trailing
            )
        } else {
            Color.card
        }
    }

    private var foregroundColor: Color {
        guard isEnabled else { return .black.opacity(0.3) }

        switch style {
        case .primary, .secondary:
            return .accent
        }
    }
}

#Preview("buttonSection") {
    VStack(spacing: 16) {
        SectionButton(title: "Label", size: 50, style: .primary) {}

        SectionButton(title: "Label", size: 50, style: .primary) {}
            .disabled(true)

        SectionButton(title: "Label", size: 56, style: .secondary) {}
    }
    .padding(24)
    .background(Color.background)
}
