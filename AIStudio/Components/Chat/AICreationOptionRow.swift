//
//  AICreationOptionRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct AICreationOptionRow: View {
    let option: AICreationOption
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                optionIcon
                    .frame(width: 24, height: 24)

                VStack(alignment: .leading, spacing: 4) {
                    Text(key: option.title)
                        .typography(style: .semiBold16)
                        .foregroundStyle(.white)
                        .tracking(0)
                        .lineLimit(1)

                    Text(key: option.subtitle)
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
            .background(CardBlurBackground(opacity: 0.6))
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
