//
//  BenefitRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BenefitRow: View {
    static let defaultSize: CGFloat = 20

    private enum Layout {
        static let iconSizeRatio: CGFloat = 1.4
        static let spacingRatio: CGFloat = 0.6
    }

    let title: String
    var size: CGFloat = BenefitRow.defaultSize
    var colorOne: Color = .aiBlue
    var colorTwo: Color = .aiPink

    private var fontSize: CGFloat { size }
    private var iconSize: CGFloat { size * Layout.iconSizeRatio }
    private var spacing: CGFloat { size * Layout.spacingRatio }

    var body: some View {
        HStack(spacing: spacing) {
            GenerateIcon()
                .fill(
                    LinearGradient(
                        colors: [colorOne, colorTwo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: iconSize, height: iconSize)

            Text(title)
                .font(AppFont.font(weight: .semiBold, size: fontSize))
                .foregroundStyle(Color.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview("benefitRow") {
    VStack(alignment: .leading, spacing: 16) {
        BenefitRow(title: "Unlimited tracking", size: 20)
        BenefitRow(title: "Unlimited tracking", size: 24)
    }
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.background)
}

#Preview("benefitRow — scaled") {
    GeometryReader { geo in
        BenefitRow(
            title: "Unlimited tracking",
            size: geo.size.width * 0.053
        )
        .padding(.horizontal, geo.size.width * 0.064)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.background)
    }
}
