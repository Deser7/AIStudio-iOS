//
//  HistoryCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 28.06.2026.
//

import SwiftUI

enum HistoryCardVariant {
    /// Figma «history/Default»: градиентные искры без круга.
    case `default`
    /// Figma «history/Variant2»: синий круг с белой иконкой Generate.
    case variant2
}

/// Карточка элемента истории (Figma «history/Default», «history/Variant2»).
struct HistoryCard: View {
    let title: String
    let subtitle: String
    var variant: HistoryCardVariant = .default
    var width: CGFloat
    let action: () -> Void

    /// Figma ref width = 358, height = 72. Базовая единица — 16px.
    private var spacing: CGFloat { width * 16 / 358 }
    private var cardHeight: CGFloat { width * 72 / 358 }
    private var horizontalPadding: CGFloat { spacing * 24 / 16 }
    private var verticalPadding: CGFloat { spacing }
    private var cornerRadius: CGFloat { spacing * 24 / 16 }
    private var contentGap: CGFloat { horizontalPadding }
    private var textSpacing: CGFloat { spacing * 4 / 16 }
    private var titleFontSize: CGFloat { spacing }
    private var subtitleFontSize: CGFloat { spacing * 14 / 16 }
    private var plainIconSize: CGFloat { spacing * 28 / 16 }
    private var circleIconSize: CGFloat { spacing * 32 / 16 }
    private var circleIconContentSize: CGFloat { circleIconSize * 49 / 80 }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: contentGap) {
                historyIcon

                VStack(alignment: .leading, spacing: textSpacing) {
                    Text(title)
                        .typography(style: .semiBold, size: titleFontSize)
                        .foregroundStyle(Color.white)
                        .tracking(0)
                        .lineLimit(1)

                    Text(subtitle)
                        .typography(style: .regular, size: subtitleFontSize)
                        .foregroundStyle(Color.white.opacity(0.5))
                        .tracking(0)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(width: width, height: cardHeight, alignment: .leading)
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
                .frame(width: plainIconSize, height: plainIconSize)
        case .variant2:
            ZStack {
                Logo(diameter: 32, preset: .blue)
            }
            .frame(width: circleIconSize, height: circleIconSize)
            .clipShape(Circle())
        }
    }

    private var cardBackground: some View {
        BlurCardBackground(
            style: .compact,
            extent: cardHeight,
            blurRadius: blurRadius,
            cardOpacity: 0.4,
            shape: shape
        )
    }
}

#Preview {
    let width: CGFloat = 358

    VStack(spacing: 8) {
        HistoryCard(
            title: "Hello, this is a test recording....",
            subtitle: "5:32 AM",
            variant: .default,
            width: width,
            action: {}
        )

        HistoryCard(
            title: "Marketing for “FitApp”",
            subtitle: "Ideas for launch, positioning, and pr...",
            variant: .variant2,
            width: width,
            action: {}
        )
    }
    .padding(24)
    .background(Color.background)
}
