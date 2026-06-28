//
//  AIVideoCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

/// Карточка фичи AI Video (Figma «AI Video»).
struct AIVideoCard: View {
    let action: () -> Void

    private var waveOpacity: CGFloat { 0.5 }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
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
                    VStack(alignment: .leading, spacing: 12) {
                        featureIcon

                        OnboardingTitleSection(
                            title: "Turn Photo\ninto Video",
                            subtitle: "Animate • Templates",
                            style: .featureCard,
                            titleTextSize: 20,
                            subtitleTextSize: 14
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 24)

                    Spacer(minLength: 0)
                        .background { waveOverlay }

                    readinessBadge
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 16)
                }
            }
            .frame(width: 172, height: 313)
            .clipShape(cardShape)
        }
        .buttonStyle(.plain)
    }

    private var waveOverlay: some View {
        Image("Wave")
            .resizable()
            .scaledToFill()
            .frame(width: 258)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .opacity(waveOpacity)
            .blendMode(.screen)
            .allowsHitTesting(false)
    }

    private var featureIcon: some View {
        MagicIcon()
            .fill(Color.white)
            .frame(width: 20, height: 20)
            .frame(width: 36, height: 36)
            .background { iconCircleBackground }
            .clipShape(Circle())
    }

    private var iconCircleBackground: some View {
        Circle()
            .fill(Color.white.opacity(0.15))
    }

    private var readinessBadge: some View {
        HStack(spacing: 8) {
            Text("Ready in seconds")
                .typography(style: .regular, size: 12)
                .foregroundStyle(Color.white)
                .tracking(0.06)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .frame(maxWidth: 101, alignment: .leading)

            MediaPlayIcon()
                .fill(Color.white)
                .frame(width: 16, height: 16)
        }
        .padding(.horizontal, 12)
        .frame(width: 149, height: 32, alignment: .center)
        .background { readinessBadgeBackground }
        .clipShape(Capsule())
    }

    private var readinessBadgeBackground: some View {
        Capsule()
            .fill(Color.white.opacity(0.3))
    }
}

#Preview {
    AIVideoCard(action: {})
        .padding(24)
        .background(Color.background)
}
