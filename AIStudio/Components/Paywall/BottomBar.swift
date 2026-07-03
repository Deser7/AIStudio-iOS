//
//  BottomBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BottomBar: View {
    var cancelText: String = "Cancel Anytime"
    var buttonTitle: String = "Label"
    var onButtonTap: () -> Void
    var onPrivacyTap: () -> Void
    var onRestoreTap: () -> Void
    var onTermsTap: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            cancelRow

            SectionButton(
                title: buttonTitle,
                style: .primary,
                action: onButtonTap
            )

            footerLinks
        }
        .padding(.top, 16)
        .frame(maxWidth: .infinity)
    }

    private var cancelRow: some View {
        HStack(spacing: 0) {
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.price)
                .frame(width: 24, height: 24)

            Text(cancelText)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(secondaryColor)
        }
    }

    private var footerLinks: some View {
        HStack {
            linkButton("Privacy Policy", action: onPrivacyTap)

            Spacer()

            linkButton("Restore Purchases", action: onRestoreTap)

            Spacer()

            linkButton("Terms of Use", action: onTermsTap)
        }
    }

    private func linkButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 11, weight: .regular))
                .foregroundStyle(secondaryColor)
        }
        .buttonStyle(.plain)
    }

    private var secondaryColor: Color {
        .white.opacity(0.5)
    }
}

#Preview {
    BottomBar(
        onButtonTap: {},
        onPrivacyTap: {},
        onRestoreTap: {},
        onTermsTap: {}
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .background(Color.background)
}
