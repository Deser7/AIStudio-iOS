//
//  AICreationOptionRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

enum AICreationOption: CaseIterable, Identifiable, Sendable {
    case talkToAI
    case createVideos
    case writeLikePro
    case understandFaster

    var id: Self { self }

    var title: String {
        switch self {
        case .talkToAI: "Talk to AI"
        case .createVideos: "Create videos"
        case .writeLikePro: "Write like a pro"
        case .understandFaster: "Understand faster"
        }
    }

    var subtitle: String {
        switch self {
        case .talkToAI: "Ask anything. Get answers fast"
        case .createVideos: "Pick a template. Done in seconds"
        case .writeLikePro: "Rewrite and improve your text"
        case .understandFaster: "Simplify complex info instantly"
        }
    }
}

struct AICreationOptionRow: View {
    let option: AICreationOption
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                optionIcon
                    .frame(width: 24, height: 24)

                VStack(alignment: .leading, spacing: 4) {
                    Text(option.title)
                        .typography(style: .semiBold16)
                        .foregroundStyle(.white)
                        .tracking(0)
                        .lineLimit(1)

                    Text(option.subtitle)
                        .typography(style: .regular14)
                        .foregroundStyle(.white.opacity(0.5))
                        .tracking(0)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 72, alignment: .leading)
            .background(
                .card,
                in: RoundedRectangle(cornerRadius: 24, style: .continuous)
            )
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var optionIcon: some View {
        switch option {
        case .talkToAI:
            GenerateIcon()
                .fill(AppGradient.main)
        case .createVideos:
            MagicIcon()
                .fill(AppGradient.main)
        case .writeLikePro:
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
        ForEach(AICreationOption.allCases) { option in
            AICreationOptionRow(option: option, action: {})
        }
    }
    .padding(24)
    .background(Color.background)
}
