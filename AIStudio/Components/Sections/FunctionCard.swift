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
    let action: () -> Void

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                featureIcon

                Spacer(minLength: 0)

                OnboardingTitleSection(
                    title: option.title,
                    subtitle: option.subtitle,
                    style: .functionCard
                )
            }
            .padding(16)
            .frame(width: 178, height: 152.5, alignment: .topLeading)
            .background { cardBackground }
            .clipShape(cardShape)
        }
        .buttonStyle(.plain)
    }

    private var featureIcon: some View {
        optionIcon
            .frame(width: 20, height: 20)
            .frame(width: 36, height: 36)
            .background { iconCircleBackground }
            .clipShape(Circle())
    }

    private var iconCircleBackground: some View {
        Circle()
            .fill(.white.opacity(0.05))
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
            .fill(.functionCard)
            .allowsHitTesting(false)
    }
}

#Preview {
    VStack(spacing: 8) {
        FunctionCard(option: .fixWriting, action: {})
        FunctionCard(option: .understandFaster, action: {})
    }
    .padding(24)
    .background(.gray)
}
