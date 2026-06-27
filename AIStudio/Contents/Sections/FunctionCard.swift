//
//  FunctionCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

enum FunctionCardOption: Sendable {
    case fixWriting
    case understandFaster

    var title: String {
        switch self {
        case .fixWriting: "Fix & Improve\nWriting"
        case .understandFaster: "Understand\nFaster"
        }
    }

    var subtitle: String {
        switch self {
        case .fixWriting: "Rewrite • Fix grammar"
        case .understandFaster: "Summarize • Key points"
        }
    }
}

/// Компактная карточка функции (Figma «AI Text» / «Understand Faster»).
struct FunctionCard: View {
    let option: FunctionCardOption
    var size: CGFloat
    let action: () -> Void

    /// Figma ref width = 178, height = 152.5. Базовая единица — 16px.
    private var cardHeight: CGFloat { size * 152.5 / 178 }
    private var padding: CGFloat { size * 16 / 178 }
    private var cornerRadius: CGFloat { size * 24 / 178 }
    private var iconCircleSize: CGFloat { size * 36 / 178 }
    private var iconContentSize: CGFloat { size * 20 / 178 }
    private var titleFontSize: CGFloat { padding }
    private var subtitleFontSize: CGFloat { size * 12 / 178 }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                featureIcon

                Spacer(minLength: 0)

                OnboardingTitleSection(
                    title: option.title,
                    subtitle: option.subtitle,
                    style: .functionCard,
                    titleTextSize: titleFontSize,
                    subtitleTextSize: subtitleFontSize
                )
            }
            .padding(padding)
            .frame(width: size, height: cardHeight, alignment: .topLeading)
            .background { cardBackground }
            .clipShape(cardShape)
        }
        .buttonStyle(.plain)
    }

    private var featureIcon: some View {
        optionIcon
            .frame(width: iconContentSize, height: iconContentSize)
            .frame(width: iconCircleSize, height: iconCircleSize)
            .background { iconCircleBackground }
            .clipShape(Circle())
    }

    private var iconCircleBackground: some View {
        Circle()
            .fill(Color.accent.opacity(AppSurface.FunctionCard.iconCircleOpacity))
    }

    @ViewBuilder
    private var optionIcon: some View {
        switch option {
        case .fixWriting:
            MagicPencil()
                .fill(AppGradient.main)
        case .understandFaster:
            PromptIcon()
                .fill(AppGradient.main)
        }
    }

    private var cardBackground: some View {
        cardShape
            .fill(Color.functionCard)
            .allowsHitTesting(false)
    }
}

#Preview {
    let size: CGFloat = 178

    VStack(spacing: 8) {
        FunctionCard(option: .fixWriting, size: size, action: {})
        FunctionCard(option: .understandFaster, size: size, action: {})
    }
    .padding(24)
    .background(Color.gray)
}
