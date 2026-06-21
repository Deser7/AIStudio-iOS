//
//  BottomBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BottomBar: View {
    static let defaultSize: CGFloat = 50

    private enum Layout {
        static let horizontalPaddingRatio: CGFloat = 24 / 50
        static let verticalSpacingRatio: CGFloat = 16 / 50
        static let iconSizeRatio: CGFloat = 16 / 50
        static let iconStrokeRatio: CGFloat = 0.1
        static let iconTextGapRatio: CGFloat = 6 / 50
        static let secondaryFontRatio: CGFloat = 12 / 50
    }

    var size: CGFloat = BottomBar.defaultSize
    var cancelText: String = "Cancel Anytime"
    var buttonTitle: String = "Label"
    var onButtonTap: () -> Void
    var onPrivacyTap: () -> Void
    var onRestoreTap: () -> Void
    var onTermsTap: () -> Void

    private var horizontalPadding: CGFloat { size * Layout.horizontalPaddingRatio }
    private var verticalSpacing: CGFloat { size * Layout.verticalSpacingRatio }
    private var iconSize: CGFloat { size * Layout.iconSizeRatio }
    private var iconTextGap: CGFloat { size * Layout.iconTextGapRatio }
    private var secondaryFontSize: CGFloat { size * Layout.secondaryFontRatio }

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
        .padding(.bottom, verticalSpacing * 0.5)
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }

    private var cancelRow: some View {
        HStack(spacing: iconTextGap) {
            RefreshIcon()
                .stroke(
                    secondaryColor,
                    style: StrokeStyle(
                        lineWidth: iconSize * Layout.iconStrokeRatio,
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

#Preview("bottomBar") {
    BottomBar(
        size: 50,
        onButtonTap: {},
        onPrivacyTap: {},
        onRestoreTap: {},
        onTermsTap: {}
    )
}

#Preview("bottomBar — scaled") {
    GeometryReader { geo in
        BottomBar(
            size: geo.size.width * 0.13,
            onButtonTap: {},
            onPrivacyTap: {},
            onRestoreTap: {},
            onTermsTap: {}
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    .background(Color.background)
}
