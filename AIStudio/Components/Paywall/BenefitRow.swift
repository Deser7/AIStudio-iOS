//
//  BenefitRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BenefitRow: View {
    let title: String
    var style: TypographyStyle = .medium16
    var icon: PaywallBenefitIcon = .generate

    private var fontSize: CGFloat { style.fontSize }
    private var iconSize: CGFloat { fontSize * 24 / 16 }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .generate:
            GenerateIcon().fill(AppGradient.main)
        case .magicPencil:
            MagicPencil().fill(AppGradient.main)
        case .prompt:
            PromptIcon().fill(AppGradient.main)
        case .magic:
            MagicIcon().fill(AppGradient.main)
        }
    }

    var body: some View {
        HStack(spacing: 8) {
            iconView
                .frame(width: iconSize, height: iconSize)

            Text(key: title)
                .typography(style: style)
                .foregroundStyle(.white)
                .lineLimit(1)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        BenefitRow(title: "Unlimited tracking", style: .medium16)
        BenefitRow(title: "Unlimited tracking", style: .bold34)
    }
    .padding()
    .background(Color.background)
}
