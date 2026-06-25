//
//  BottomBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BottomBar: View {
    static let defaultSize: CGFloat = 50

    var size: CGFloat = BottomBar.defaultSize
    var cancelText: String = "Cancel Anytime"
    var buttonTitle: String = "Label"
    var onButtonTap: () -> Void
    var onPrivacyTap: () -> Void
    var onRestoreTap: () -> Void
    var onTermsTap: () -> Void

    private var horizontalPadding: CGFloat { size * 24 / 50 }
    private var verticalSpacing: CGFloat { size * 16 / 50 }
    private var iconSize: CGFloat { size * 16 / 50 }
    private var iconTextGap: CGFloat { size * 6 / 50 }
    private var secondaryFontSize: CGFloat { size * 12 / 50 }
    private var bottomPadding: CGFloat { verticalSpacing * 0.5 }
    private var iconStrokeWidth: CGFloat { iconSize * 0.1 }

    var body: some View {
        VStack(spacing: verticalSpacing) {
            cancelRow

            SectionButton(
                title: buttonTitle,
                size: size,
                style: .primary,
                action: onButtonTap
            )

            footerLinks
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.top, verticalSpacing)
        .padding(.bottom, bottomPadding)
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }

    private var cancelRow: some View {
        HStack(spacing: iconTextGap) {
            RefreshIcon()
                .stroke(
                    secondaryColor,
                    style: StrokeStyle(
                        lineWidth: iconStrokeWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: iconSize, height: iconSize)

            Text(cancelText)
                .font(AppFont.font(weight: .medium, size: secondaryFontSize))
                .foregroundStyle(secondaryColor)
        }
    }

    private var footerLinks: some View {
        HStack {
            linkButton("Privacy Policy", action: onPrivacyTap)

            Spacer(minLength: 0)

            linkButton("Restore Purchases", action: onRestoreTap)

            Spacer(minLength: 0)

            linkButton("Terms of Use", action: onTermsTap)
        }
    }

    private func linkButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.font(weight: .medium, size: secondaryFontSize))
                .foregroundStyle(secondaryColor)
        }
        .buttonStyle(.plain)
    }

    private var secondaryColor: Color {
        .accent.opacity(0.5)
    }
}

#Preview {
    BottomBar(
        size: BottomBar.defaultSize,
        onButtonTap: {},
        onPrivacyTap: {},
        onRestoreTap: {},
        onTermsTap: {}
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .background(Color.background)
}
