//
//  ChatNavigationBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

struct ChatNavigationBar: View {
    let title: String
    let subtitle: String
    var preset = AppGradient.Preset.blue
    let onBack: () -> Void
    let onRegenerate: () -> Void

    private let contentSpacing: CGFloat = 10
    private let horizontalPadding: CGFloat = 16
    private let barHeight: CGFloat = 75
    private let logoSize: CGFloat = 32
    private let regenerateIconSize: CGFloat = 24
    private let actionTapSize: CGFloat = 44
    private let backIconSize: CGFloat = 17
    private let borderHeight: CGFloat = 0.5

    private var borderColor: Color {
        Color.accent.opacity(0.1)
    }

    var body: some View {
        HStack(spacing: contentSpacing) {
            backButton

            HStack(spacing: contentSpacing) {
                Logo(size: logoSize, preset: preset)

                OnboardingTitleSection(
                    title: title,
                    subtitle: subtitle,
                    style: .navigation
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: contentSpacing)

            regenerateButton
        }
        .padding(.horizontal, horizontalPadding)
        .frame(maxWidth: .infinity)
        .frame(height: barHeight)
        .background { background }
        .overlay(alignment: .bottom) { bottomBorder }
    }

    private var backButton: some View {
        Button(action: onBack) {
            Image(systemName: "chevron.left")
                .font(.system(size: backIconSize, weight: .semibold))
                .foregroundStyle(Color.accent)
                .frame(width: actionTapSize, height: actionTapSize, alignment: .leading)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Back"))
    }

    private var regenerateButton: some View {
        Button(action: onRegenerate) {
            RegenerateIcon()
                .fill(Color.accent)
                .frame(width: regenerateIconSize, height: regenerateIconSize)
                .frame(width: actionTapSize, height: actionTapSize)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Regenerate"))
    }

    private var background: some View {
        ZStack {
            BackdropBlurView()

            Color.card.opacity(AppSurface.CardOpacity.compact)
        }
    }

    private var bottomBorder: some View {
        Rectangle()
            .fill(borderColor)
            .frame(height: borderHeight)
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
            preset: .blue,
            onBack: {},
            onRegenerate: {}
        )

        ChatNavigationBar(
            title: "AI Chat",
            subtitle: "26.03.2026",
            preset: .purple,
            onBack: {},
            onRegenerate: {}
        )

        Spacer()
    }
    .background(Color.green)
}
