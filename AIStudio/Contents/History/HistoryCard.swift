//
//  HistoryCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 28.06.2026.
//

import SwiftUI

enum HistoryCardVariant {
    case `default`
    case variant2
}

struct HistoryCard: View {
    let title: String
    let subtitle: String
    var variant: HistoryCardVariant = .default
    let action: () -> Void

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 24) {
                historyIcon

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .typography(style: .semiBold, size: 16)
                        .foregroundStyle(Color.white)
                        .tracking(0)
                        .lineLimit(1)

                    Text(subtitle)
                        .typography(style: .regular, size: 14)
                        .foregroundStyle(Color.white.opacity(0.5))
                        .tracking(0)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(width: 358, height: 72, alignment: .leading)
            .background { cardBackground }
            .clipShape(shape)
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
            Logo(diameter: 32, preset: .blue)
                .frame(width: 32, height: 32)
                .clipShape(Circle())
        }
    }

    private var cardBackground: some View {
        BlurCardBackground(
            style: .compact,
            extent: 72,
            blurRadius: AppSurface.blurRadius,
            cardOpacity: 0.4,
            shape: shape
        )
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
