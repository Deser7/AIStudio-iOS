//
//  AIVideoCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

/// Карточка фичи AI Video (Figma «AI Video»).
struct AIVideoCard: View {
    var width: CGFloat
    let action: () -> Void

    /// Figma ref width = 172, height = 313. Базовая единица — 16px.
    private var cardHeight: CGFloat { width * 313 / 172 }
    private var horizontalPadding: CGFloat { width * 16 / 172 }
    private var topPadding: CGFloat { width * 24 / 172 }
    private var bottomPadding: CGFloat { width * 16 / 172 }
    private var cornerRadius: CGFloat { width * 24 / 172 }
    private var iconCircleSize: CGFloat { width * 36 / 172 }
    private var iconContentSize: CGFloat { width * 20 / 172 }
    private var titleFontSize: CGFloat { width * 20 / 172 }
    private var subtitleFontSize: CGFloat { width * 14 / 172 }
    private var contentSpacing: CGFloat { width * 12 / 172 }
    private var badgeWidth: CGFloat { width * 149 / 172 }
    private var badgeHeight: CGFloat { width * 32 / 172 }
    private var badgeFontSize: CGFloat { width * 12 / 172 }
    private var badgeHorizontalPadding: CGFloat { width * 12 / 172 }
    private var badgeContentGap: CGFloat { width * 8 / 172 }
    private var playIconSize: CGFloat { width * 16 / 172 }
    private var badgeTextMaxWidth: CGFloat {
        badgeWidth - badgeHorizontalPadding * 2 - playIconSize - badgeContentGap
    }

    /// Figma ref wave opacity = 50%.
    private var waveOpacity: CGFloat { 0.5 }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                AppGradient.linear(
                    from: .aiBlue,
                    to: .aiPink,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                VStack(spacing: 0) {
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, topPadding)

                    Spacer(minLength: 0)
                        .background { waveOverlay }

                    readinessBadge
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, bottomPadding)
                }
            }
            .frame(width: width, height: cardHeight)
            .clipShape(cardShape)
        }
        .buttonStyle(.plain)
    }

    private var waveOverlay: some View {
        Image("Wave")
            .resizable()
            .scaledToFill()
            .frame(width: width * 1.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .opacity(waveOpacity)
            .blendMode(.screen)
            .allowsHitTesting(false)
    }

    private var featureIcon: some View {
        MagicIcon()
            .fill(Color.white)
            .frame(width: iconContentSize, height: iconContentSize)
            .frame(width: iconCircleSize, height: iconCircleSize)
            .background { iconCircleBackground }
            .clipShape(Circle())
    }

    private var iconCircleBackground: some View {
        Circle()
            .fill(Color.white.opacity(0.15))
    }

    private var readinessBadge: some View {
        HStack(spacing: badgeContentGap) {
            Text("Ready in seconds")
                .typography(style: .regular, size: badgeFontSize)
                .foregroundStyle(Color.white)
                .tracking(badgeFontSize * 0.06 / 12)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .frame(maxWidth: badgeTextMaxWidth, alignment: .leading)

            MediaPlayIcon()
                .fill(Color.white)
                .frame(width: playIconSize, height: playIconSize)
        }
        .padding(.horizontal, badgeHorizontalPadding)
        .frame(width: badgeWidth, height: badgeHeight, alignment: .center)
        .background { readinessBadgeBackground }
        .clipShape(Capsule())
    }

    private var readinessBadgeBackground: some View {
        Capsule()
            .fill(Color.white.opacity(0.3))
    }
}

#Preview {
    let size: CGFloat = 172

    AIVideoCard(width: size, action: {})
        .padding(24)
        .background(Color.background)
}
