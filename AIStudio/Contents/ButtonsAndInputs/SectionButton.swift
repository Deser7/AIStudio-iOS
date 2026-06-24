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
    var size: CGFloat = 50
    var style: Style = .primary
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.font(weight: .semiBold, size: size * 16 / 50))
                .foregroundStyle(isEnabled ? Color.accent : Color.black.opacity(0.3))
                .padding(.horizontal, size * 12 / 50)
                .frame(maxWidth: .infinity)
                .frame(height: size)
                .background {
                    if isEnabled, style == .primary {
                        AppGradient.main
                    } else {
                        Color.card
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: size * 24 / 50))
        }
        .buttonStyle(.plain)
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
