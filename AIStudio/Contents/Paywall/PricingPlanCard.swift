//
//  PricingPlanCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct PricingPlanItem: Identifiable, Equatable {
    let id: String
    let periodLabel: String
    let price: String
    let badge: String?
}

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
                            .typography(style: .medium, size: 16)

                        Text("/ week")
                            .typography(style: .regular, size: 16)
                    }
                    .foregroundStyle(Color.white)

                    Text(price)
                        .typography(style: .regular, size: 14)
                        .foregroundStyle(Color.price)
                }

                Spacer(minLength: 0)

                if let badge {
                    Text(badge)
                        .typography(style: .medium, size: 14)
                        .foregroundStyle(Color.white)
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
            .background(Color.card)
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
                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
        }
    }
}

struct PricingPlans: View {
    let plans: [PricingPlanItem]
    @Binding var selectedPlanID: String
    var spacing: CGFloat?

    private var planSpacing: CGFloat {
        spacing ?? 16
    }

    var body: some View {
        VStack(spacing: planSpacing) {
            ForEach(plans) { plan in
                PricingPlanCard(
                    periodLabel: plan.periodLabel,
                    price: plan.price,
                    badge: plan.badge,
                    isSelected: selectedPlanID == plan.id
                ) {
                    selectedPlanID = plan.id
                }
            }
        }
    }
}

#Preview {
    struct PreviewContainer: View {
        @State private var selectedPlanID = "year"

        private let plans = [
            PricingPlanItem(
                id: "month",
                periodLabel: "Month $1.99",
                price: "$ 7.99",
                badge: nil
            ),
            PricingPlanItem(
                id: "year",
                periodLabel: "Year $1.27",
                price: "$ 69.99",
                badge: "SAVE 80%"
            )
        ]

        var body: some View {
            PricingPlans(
                plans: plans,
                selectedPlanID: $selectedPlanID
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
            .background(Color.background)
        }
    }

    return PreviewContainer()
}
