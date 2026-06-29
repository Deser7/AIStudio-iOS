//
//  BenefitRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct BenefitRow: View {
    let title: String
    var style: Typography.Style = .semiBold20

    private var fontSize: CGFloat { style.fontSize }
    private var rowSpacing: CGFloat { fontSize * 12 / 20 }
    private var iconSize: CGFloat { fontSize * 28 / 20 }

    var body: some View {
        HStack(spacing: rowSpacing) {
            GenerateIcon()
                .fill(AppGradient.main)
                .frame(width: iconSize, height: iconSize)

            Text(title)
                .typography(style: style)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        BenefitRow(title: "Unlimited tracking", style: .semiBold20)
        BenefitRow(title: "Unlimited tracking", style: .semiBold24)
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 24)
    .background(Color.background)
}
