//
//  HistoryCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 28.06.2026.
//

import SwiftUI

struct HistoryCard: View {
    let title: String
    let subtitle: String
    var variant: HistoryCardVariant = .default
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 24) {
                historyIcon

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .typography(style: .semiBold16)
                        .foregroundStyle(.white)
                        .tracking(0)
                        .lineLimit(1)

                    Text(subtitle)
                        .typography(style: .regular14)
                        .foregroundStyle(.white.opacity(0.5))
                        .tracking(0)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(width: 358, height: 72, alignment: .leading)
            .background(CardBlurBackground(opacity: 0.4))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var historyIcon: some View {
        switch variant {
        case .default:
            GenerateIcon()
                .fill(AppGradient.main)
                .frame(width: 28, height: 28)
        case .variant2:
            Logo(size: 32, preset: .blue, icon: .generate)
                .frame(width: 32, height: 32)
                .clipShape(Circle())
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        HistoryCard(
            title: "Hello, this is a test recording....",
            subtitle: "5:32 AM",
            variant: .default,
            action: {}
        )

        HistoryCard(
            title: "Marketing for “FitApp”",
            subtitle: "Ideas for launch, positioning, and pr...",
            variant: .variant2,
            action: {}
        )
    }
    .padding(24)
    .background(Color.background)
}
