//
//  BenefitRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BenefitRow: View {
    let title: String
    var size: CGFloat

    private var rowSpacing: CGFloat { size * 12 / 20 }
    private var iconSize: CGFloat { size * 28 / 20 }

    var body: some View {
        HStack(spacing: rowSpacing) {
            GenerateIcon()
                .fill(AppGradient.main)
                .frame(width: iconSize, height: iconSize)

            Text(title)
                .font(AppFont.font(weight: .semiBold, size: size))
                .foregroundStyle(Color.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    let size: CGFloat = 20

    VStack(alignment: .leading, spacing: size * 16 / 20) {
        BenefitRow(title: "Unlimited tracking", size: size)
        BenefitRow(title: "Unlimited tracking", size: size * 24 / 20)
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 24)
    .background(Color.background)
}
