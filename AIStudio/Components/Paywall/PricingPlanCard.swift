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
    var badge: String? = nil
    var isSelected: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 0) {
                        Text(periodLabel)
                            .typography(style: .medium16)

                        Text("/ week")
                            .typography(style: .regular16)
                    }
                    .foregroundStyle(.white)

                    Text(price)
                        .typography(style: .regular14)
                        .foregroundStyle(.price)
                }

                Spacer()

                if let badge {
                    Text(badge)
                        .typography(style: .medium14)
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(AppGradient.main)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, minHeight: 72, alignment: .leading)
            .background(.card)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay { borderOverlay }
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if isSelected {
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(AppGradient.main, lineWidth: 1)
        } else {
            RoundedRectangle(cornerRadius: 24)
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
                badge: "SAVE 80%",
                isSelected: true,
                action: {}
            )
        }
        .padding()
    }
}
