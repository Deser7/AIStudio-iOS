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

struct FunctionCard: View {
    let option: FunctionCardOption
    let action: () -> Void

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
            .padding()
            .frame(width: 178, height: 152.5, alignment: .topLeading)
            .background(.functionCard)
            .clipShape(AppShape.card)
        }
        .buttonStyle(.plain)
    }

    private var featureIcon: some View {
        optionIcon
            .frame(width: 20, height: 20)
            .frame(width: 36, height: 36)
            .background(.white.opacity(0.05))
            .clipShape(Circle())
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
}

#Preview {
    VStack(spacing: 8) {
        FunctionCard(option: .fixWriting, action: {})
        FunctionCard(option: .understandFaster, action: {})
    }
    .padding(24)
    .background(.gray)
}
