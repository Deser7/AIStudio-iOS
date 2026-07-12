//
//  AIVideoCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

struct AIVideoCard: View {
    let action: () -> Void

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
                            title: "Turn Photo into Video",
                            subtitle: "Animate • Templates",
                            style: .featureCard
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
            .clipShape(AppShape.card)
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
            .opacity(0.5)
            .blendMode(.screen)
            .allowsHitTesting(false)
    }

    private var featureIcon: some View {
        MagicIcon()
            .fill(.white)
            .frame(width: 20, height: 20)
            .frame(width: 36, height: 36)
            .background(.white.opacity(0.15))
            .clipShape(Circle())
    }

    private var readinessBadge: some View {
        HStack(spacing: 8) {
            Text(key: "Ready in seconds")
                .typography(style: .regular12)
                .foregroundStyle(.white)
                .tracking(0.06)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
                .frame(maxWidth: 101, alignment: .leading)

            MediaPlayIcon()
                .fill(.white)
                .frame(width: 16, height: 16)
        }
        .padding(.horizontal, 12)
        .frame(width: 149, height: 32, alignment: .center)
        .background(.white.opacity(0.3))
        .clipShape(Capsule())
    }
}

#Preview {
    AIVideoCard(action: {})
        .scaleEffect(2)
        .padding(24)
        .background(Color.background)
}
