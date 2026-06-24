//
//  ChatNavigationBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

struct ChatNavigationBar: View {
    private enum Layout {
        static let horizontalPadding: CGFloat = 16
        static let contentSpacing: CGFloat = 10
        static let titleSpacing: CGFloat = 2
        static let barHeight: CGFloat = 75
        static let logoSize: CGFloat = 32
        static let regenerateIconSize: CGFloat = 24
        static let actionTapSize: CGFloat = 44
        static let backIconSize: CGFloat = 17
        static let overlayOpacity: CGFloat = 0.4
        static let subtitleOpacity: CGFloat = 0.3
        static let bottomBorderWidth: CGFloat = 0.5
        static let overlayColor = Color(
            red: 31 / 255,
            green: 25 / 255,
            blue: 31 / 255
        )
    }

    let title: String
    let subtitle: String
    var logoColorOne: Color = .logoBlueOne
    var logoColorTwo: Color = .logoBlueTwo
    let onBack: () -> Void
    let onRegenerate: () -> Void

    var body: some View {
        HStack(spacing: Layout.contentSpacing) {
            backButton

            HStack(spacing: Layout.contentSpacing) {
                Logo(
                    size: Layout.logoSize,
                    colorOne: logoColorOne,
                    colorTwo: logoColorTwo
                )

                titleSection
            }

            Spacer(minLength: Layout.contentSpacing)

            regenerateButton
        }
        .padding(.horizontal, Layout.horizontalPadding)
        .frame(maxWidth: .infinity)
        .frame(height: Layout.barHeight)
        .background { background }
        .overlay(alignment: .bottom) { bottomBorder }
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: Layout.titleSpacing) {
            Text(title)
                .typography(Typography.semiBold20)
                .foregroundStyle(Color.accent)
                .lineLimit(1)

            Text(subtitle)
                .typography(Typography.regular14)
                .foregroundStyle(Color.accent.opacity(Layout.subtitleOpacity))
                .lineLimit(1)
        }
    }

    private var backButton: some View {
        Button(action: onBack) {
            Image(systemName: "chevron.left")
                .font(.system(size: Layout.backIconSize, weight: .semibold))
                .foregroundStyle(Color.accent)
                .frame(width: Layout.actionTapSize, height: Layout.actionTapSize, alignment: .leading)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Back"))
    }

    private var regenerateButton: some View {
        Button(action: onRegenerate) {
            RegenerateIcon()
                .fill(Color.accent)
                .frame(width: Layout.regenerateIconSize, height: Layout.regenerateIconSize)
                .frame(width: Layout.actionTapSize, height: Layout.actionTapSize)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Regenerate"))
    }

    private var background: some View {
        ZStack {
            BackdropBlurView()

            Layout.overlayColor
                .opacity(Layout.overlayOpacity)
        }
    }

    private var bottomBorder: some View {
        Rectangle()
            .fill(Color.accent.opacity(0.1))
            .frame(height: Layout.bottomBorderWidth)
    }
}

// MARK: - Previews

#Preview("chatNavigationBar") {
    VStack(spacing: 0) {
        ChatNavigationBar(
            title: "AI Chat",
            subtitle: "26.03.2026",
            onBack: {},
            onRegenerate: {}
        )

        Spacer()
    }
    .background(Color.green)
}

#Preview("chatNavigationBar — logo variants") {
    VStack(spacing: 0) {
        ChatNavigationBar(
            title: "AI Chat",
            subtitle: "26.03.2026",
            logoColorOne: .logoBlueOne,
            logoColorTwo: .logoBlueTwo,
            onBack: {},
            onRegenerate: {}
        )

        ChatNavigationBar(
            title: "AI Chat",
            subtitle: "26.03.2026",
            logoColorOne: .logoPurpleOne,
            logoColorTwo: .logoPurpleTwo,
            onBack: {},
            onRegenerate: {}
        )

        Spacer()
    }
    .background(Color.green)
}
