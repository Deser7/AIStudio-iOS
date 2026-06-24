//
//  BenefitRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BenefitRow: View {
    let title: String
    var size: CGFloat = 20

    var body: some View {
        HStack(spacing: size * 0.6) {
            GenerateIcon()
                .fill(AppGradient.main)
                .frame(width: size * 1.4, height: size * 1.4)

            Text(title)
                .font(AppFont.font(weight: .semiBold, size: size))
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
