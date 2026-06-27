//
//  AIVideoCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

/// Карточка фичи AI Video (Figma «AI Video»).
struct AIVideoCard: View {
    var size: CGFloat
    let action: () -> Void

    /// Figma ref width = 172, height = 313. Базовая единица — 16px.
    private var cardHeight: CGFloat { size * 313 / 172 }
    private var horizontalPadding: CGFloat { size * 16 / 172 }
    private var topPadding: CGFloat { size * 24 / 172 }
    private var bottomPadding: CGFloat { size * 16 / 172 }
    private var cornerRadius: CGFloat { size * 24 / 172 }
    private var iconCircleSize: CGFloat { size * 32 / 172 }
    private var iconContentSize: CGFloat { iconCircleSize * 20 / 32 }
    private var titleFontSize: CGFloat { size * 20 / 172 }
    private var subtitleFontSize: CGFloat { size * 14 / 172 }
    private var contentSpacing: CGFloat { size * 16 / 172 }
    private var badgeWidth: CGFloat { size * 149 / 172 }
    private var badgeHeight: CGFloat { size * 32 / 172 }
    private var badgeFontSize: CGFloat { size * 12 / 172 }
    private var badgeHorizontalPadding: CGFloat { size * 12 / 172 }
    private var playIconSize: CGFloat { size * 16 / 172 }
    private var blurRadius: CGFloat { horizontalPadding * AppSurface.blurRadius / 16 }
    private var waveHeight: CGFloat { size * 80 / 172 }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                AppGradient.linear(
                    from: .aiBlue,
                    to: .aiPink,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                Image("Wave")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: waveHeight)
                    .opacity(0.5)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .allowsHitTesting(false)

                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: contentSpacing) {
                        featureIcon

                        OnboardingTitleSection(
                            title: "Turn Photo\ninto Video",
                            subtitle: "Animate • Templates",
                            style: .featureCard,
                            titleTextSize: titleFontSize,
                            subtitleTextSize: subtitleFontSize
                        )
                    }

                    Spacer(minLength: 0)

                    readinessBadge
                }
                .padding(.top, topPadding)
                .padding(.bottom, bottomPadding)
                .padding(.horizontal, horizontalPadding)
                .frame(width: size, height: cardHeight, alignment: .topLeading)
            }
            .frame(width: size, height: cardHeight)
            .clipShape(cardShape)
        }
        .buttonStyle(.plain)
    }

    private var featureIcon: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: iconCircleSize, height: iconCircleSize)

            MagicIcon()
                .fill(Color.white)
                .frame(width: iconContentSize, height: iconContentSize)
        }
    }

    private var readinessBadge: some View {
        HStack(spacing: badgeHorizontalPadding * 0.5) {
            Text("Ready in seconds")
                .typography(Typography.regular(size: badgeFontSize))
                .foregroundStyle(Color.white)
                .tracking(size * 0.06 / 172)
                .lineLimit(1)

            Spacer(minLength: 0)

            MediaPlayIcon()
                .fill(Color.white)
                .frame(width: playIconSize, height: playIconSize)
        }
        .padding(.horizontal, badgeHorizontalPadding)
        .frame(width: badgeWidth, height: badgeHeight)
        .background { readinessBadgeBackground }
        .clipShape(Capsule())
    }

    private var readinessBadgeBackground: some View {
        ZStack {
            BackdropBlurView()
                .frame(
                    width: badgeWidth + blurRadius * AppSurface.BlurFrame.paddingMultiplier,
                    height: badgeHeight + blurRadius * AppSurface.BlurFrame.paddingMultiplier
                )

            Capsule()
                .fill(Color.white.opacity(0.3))
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    let size: CGFloat = 172

    AIVideoCard(size: size, action: {})
        .padding(24)
        .background(Color.background)
}
