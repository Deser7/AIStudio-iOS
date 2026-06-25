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
    var size: CGFloat
    let action: () -> Void

    private var cornerRadius: CGFloat { size * 1 / 3 }
    private var titleFontSize: CGFloat { size * 2 / 9 }
    private var secondaryFontSize: CGFloat { size * 7 / 36 }
    private var textSpacing: CGFloat { size * 1 / 18 }
    private var borderWidth: CGFloat { max(size * 1 / 72, 1) }
    private var badgeHorizontalPadding: CGFloat { size * 5 / 36 }
    private var badgeVerticalPadding: CGFloat { size * 1 / 12 }

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: textSpacing) {
                    HStack(spacing: 0) {
                        Text(periodLabel)
                            .font(AppFont.font(weight: .medium, size: titleFontSize))

                        Text("/ week")
                            .font(AppFont.font(weight: .regular, size: titleFontSize))
                    }
                    .foregroundStyle(Color.accent)

                    Text(price)
                        .font(AppFont.font(weight: .regular, size: secondaryFontSize))
                        .foregroundStyle(Color.price)
                }

                Spacer(minLength: 0)

                if let badge {
                    Text(badge)
                        .font(AppFont.font(weight: .medium, size: secondaryFontSize))
                        .foregroundStyle(Color.accent)
                        .textCase(.uppercase)
                        .padding(.horizontal, badgeHorizontalPadding)
                        .padding(.vertical, badgeVerticalPadding)
                        .background(AppGradient.main)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, titleFontSize)
            .padding(.vertical, secondaryFontSize)
            .frame(maxWidth: .infinity, minHeight: size, alignment: .leading)
            .background(Color.card)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay { borderOverlay }
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if isSelected {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(AppGradient.main, lineWidth: borderWidth)
        } else {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(Color.accent.opacity(0.25), lineWidth: borderWidth)
        }
    }
}

struct PricingPlans: View {
    let plans: [PricingPlanItem]
    @Binding var selectedPlanID: String
    var size: CGFloat
    var spacing: CGFloat?

    private var planSpacing: CGFloat {
        spacing ?? size * 2 / 9
    }

    var body: some View {
        VStack(spacing: planSpacing) {
            ForEach(plans) { plan in
                PricingPlanCard(
                    periodLabel: plan.periodLabel,
                    price: plan.price,
                    badge: plan.badge,
                    isSelected: selectedPlanID == plan.id,
                    size: size
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
                selectedPlanID: $selectedPlanID,
                size: 72
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
            .background(Color.background)
        }
    }

    return PreviewContainer()
}
