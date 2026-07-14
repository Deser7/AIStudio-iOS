//
//  PricingPlanCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct PricingPlanCard: View {
    let periodLabel: String
    let price: String
    var badgeDiscount: Double? = nil
    var isSelected: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 0) {
                        Text(key: periodLabel)
                            .typography(style: .medium16)

                        Text(key: "/ week")
                            .typography(style: .regular16)
                    }
                    .foregroundStyle(.white)

                    Text(verbatim: price)
                        .typography(style: .regular14)
                        .foregroundStyle(.price)
                }

                Spacer()

                if let badgeDiscount {
                    discountBadge(discount: badgeDiscount)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, minHeight: 72, alignment: .leading)
            .background(.card)
            .clipShape(AppShape.card)
            .overlay { borderOverlay }
        }
        .buttonStyle(.plain)
    }

    private func discountBadge(discount: Double) -> some View {
        HStack(spacing: 4) {
            Text(key: "SAVE")
            Text(discount, format: .percent.precision(.fractionLength(0)))
        }
        .typography(style: .medium14)
        .foregroundStyle(.white)
        .textCase(.uppercase)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(AppGradient.main)
        .clipShape(Capsule())
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if isSelected {
            AppShape.card
                .strokeBorder(AppGradient.main, lineWidth: 1)
        } else {
            AppShape.card
                .strokeBorder(.white.opacity(0.25), lineWidth: 1)
        }
    }
}

#Preview {
    ZStack {
        Color.background
            .ignoresSafeArea()
        
        VStack(spacing: 16) {
            PricingPlanCard(
                periodLabel: "Month $1.99",
                price: "$ 7.99",
                isSelected: false,
                action: {}
            )
            
            PricingPlanCard(
                periodLabel: "Year $1.27",
                price: "$ 69.99",
                badgeDiscount: 0.8,
                isSelected: true,
                action: {}
            )
        }
        .padding()
    }
}
