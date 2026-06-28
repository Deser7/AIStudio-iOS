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
    var style: Style = .primary
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    private var titleColor: Color {
        isEnabled ? Color.white : Color.black.opacity(0.3)
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .typography(style: .semiBold16)
                .foregroundStyle(titleColor)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background { backgroundFill }
                .clipShape(RoundedRectangle(cornerRadius: 24))
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
    VStack(spacing: 16) {
        SectionButton(title: "Label", style: .primary) {}
        SectionButton(title: "Label", style: .primary) {}
            .disabled(true)
        SectionButton(title: "Label", style: .secondary) {}
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 24)
    .background(Color.background)
}
