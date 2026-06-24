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
    static let defaultSize: CGFloat = 72

    let periodLabel: String
    let price: String
    var badge: String? = nil
    var isSelected: Bool = false
    var size: CGFloat = PricingPlanCard.defaultSize
    let action: () -> Void

    private var cornerRadius: CGFloat { size * 24 / 72 }
    private var horizontalPadding: CGFloat { size * 16 / 72 }
    private var verticalPadding: CGFloat { size * 14 / 72 }
    private var titleFontSize: CGFloat { size * 16 / 72 }
    private var priceFontSize: CGFloat { size * 14 / 72 }
    private var badgeFontSize: CGFloat { size * 14 / 72 }
    private var textSpacing: CGFloat { size * 4 / 72 }
    private var borderWidth: CGFloat { max(size * 1 / 72, 1) }
    private var badgeHorizontalPadding: CGFloat { size * 10 / 72 }
    private var badgeVerticalPadding: CGFloat { size * 6 / 72 }

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
                        .font(AppFont.font(weight: .regular, size: priceFontSize))
                        .foregroundStyle(Color.price)
                }

                Spacer(minLength: 0)

                if let badge {
                    Text(badge)
                        .font(AppFont.font(weight: .medium, size: badgeFontSize))
                        .foregroundStyle(Color.accent)
                        .textCase(.uppercase)
                        .padding(.horizontal, badgeHorizontalPadding)
                        .padding(.vertical, badgeVerticalPadding)
                        .background(AppGradient.main)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
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
    var size: CGFloat = PricingPlanCard.defaultSize
    var spacing: CGFloat?

    private var planSpacing: CGFloat {
        spacing ?? size * (16 / 72)
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

#Preview("pricing plans") {
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
            .padding(24)
            .background(Color.background)
        }
    }

    return PreviewContainer()
}

#Preview("pricing plans — scaled") {
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
            GeometryReader { geo in
                PricingPlans(
                    plans: plans,
                    selectedPlanID: $selectedPlanID,
                    size: geo.size.width * 0.19
                )
                .padding(.horizontal, geo.size.width * 0.064)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.background)
            }
        }
    }

    return PreviewContainer()
}
