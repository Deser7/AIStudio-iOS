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

    private enum Layout {
        static let height: CGFloat = 50
        static let cornerRadius: CGFloat = 24
        static let padding: CGFloat = 12
    }

    let title: String
    var style: Style = .primary
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        Button(action: action) {
            Text(title)
                .typography(Typography.semiBold16)
                .foregroundStyle(foregroundColor)
                .padding(.horizontal, Layout.padding)
                .frame(maxWidth: .infinity)
                .frame(height: Layout.height)
                .background { background }
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: Layout.cornerRadius
                    )
                )
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
        guard isEnabled else { return .accent.opacity(0.6) }

        switch style {
        case .primary, .secondary:
            return .accent
        }
    }
}

#Preview("buttonSection") {
    VStack(spacing: 16) {
        SectionButton(title: "Label", style: .primary) {}

        SectionButton(title: "Label", style: .primary) {}
            .disabled(true)

        SectionButton(title: "Label", style: .secondary) {}
    }
    .padding(24)
    .background(Color.background)
}
