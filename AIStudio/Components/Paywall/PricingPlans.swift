//
//  PricingPlans.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 30.06.2026.
//


import SwiftUI

struct PricingPlans: View {
    let plans: [PricingPlanItem]
    @Binding var selectedPlanID: String

    var body: some View {
        VStack(spacing: 16) {
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
