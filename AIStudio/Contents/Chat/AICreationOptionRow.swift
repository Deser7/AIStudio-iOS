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
    var size: CGFloat
    var titleFontSize: CGFloat
    var subtitleFontSize: CGFloat
    let action: () -> Void

    /// Figma ref row height = 72. Базовая единица — 16px.
    private var spacing: CGFloat { size * 16 / 72 }
    private var cornerRadius: CGFloat { spacing * 24 / 16 }
    private var iconSize: CGFloat { cornerRadius }
    private var textSpacing: CGFloat { spacing * 4 / 16 }

    var body: some View {
        Button(action: action) {
            HStack(spacing: spacing) {
                optionIcon
                    .frame(width: iconSize, height: iconSize)

                VStack(alignment: .leading, spacing: textSpacing) {
                    Text(option.title)
                        .typography(style: .semiBold, size: titleFontSize)
                        .foregroundStyle(Color.white)
                        .tracking(0)
                        .lineLimit(1)

                    Text(option.subtitle)
                        .typography(style: .regular, size: subtitleFontSize)
                        .foregroundStyle(Color.white.opacity(0.5))
                        .tracking(0)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, spacing)
            .frame(maxWidth: .infinity, minHeight: size, alignment: .leading)
            .background(
                Color.card,
                in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
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
    let rowHeight: CGFloat = 72
    let fontSize: CGFloat = 16
    let subtitleFontSize: CGFloat = 14

    VStack(spacing: 8) {
        ForEach(AICreationOption.allCases) { option in
            AICreationOptionRow(
                option: option,
                size: rowHeight,
                titleFontSize: fontSize,
                subtitleFontSize: subtitleFontSize,
                action: {}
            )
        }
    }
    .padding(24)
    .background(Color.background)
}
