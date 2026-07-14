//
//  PaywallViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 30.06.2026.
//

import Foundation
import Observation

@Observable
final class PaywallViewModel {
    let title = "Create anything you want"
    let unlockButtonTitle = "Unlock now"
    let cancelText = "Cancel Anytime"

    var selectedPlanID: String
    var isCloseButtonVisible = false

    let benefits: [PaywallBenefit]
    let plans: [PricingPlanItem]

    private var closeButtonTask: Task<Void, Never>?

    private let onClose: () -> Void
    private let onUnlock: (String) -> Void
    private let onPrivacyPolicy: () -> Void
    private let onRestorePurchases: () -> Void
    private let onTermsOfUse: () -> Void

    init(
        benefits: [PaywallBenefit] = PaywallViewModel.defaultBenefits,
        plans: [PricingPlanItem] = PaywallViewModel.defaultPlans,
        onClose: @escaping () -> Void = {},
        onUnlock: @escaping (String) -> Void = { _ in },
        onPrivacyPolicy: @escaping () -> Void = {},
        onRestorePurchases: @escaping () -> Void = {},
        onTermsOfUse: @escaping () -> Void = {}
    ) {
        self.benefits = benefits
        self.plans = plans
        self.selectedPlanID = plans.first(where: { $0.badgeDiscount != nil })?.id ?? plans[0].id
        self.onClose = onClose
        self.onUnlock = onUnlock
        self.onPrivacyPolicy = onPrivacyPolicy
        self.onRestorePurchases = onRestorePurchases
        self.onTermsOfUse = onTermsOfUse
    }

    func onAppear() {
        closeButtonTask?.cancel()
        isCloseButtonVisible = false

        closeButtonTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(2))
            guard !Task.isCancelled else { return }
            isCloseButtonVisible = true
        }
    }

    func onDisappear() {
        closeButtonTask?.cancel()
        closeButtonTask = nil
    }

    func selectPlan(_ planID: String) {
        selectedPlanID = planID
    }

    func closeTapped() {
        onClose()
    }

    func unlockTapped() {
        onUnlock(selectedPlanID)
    }

    func privacyPolicyTapped() {
        onPrivacyPolicy()
    }

    func restorePurchasesTapped() {
        onRestorePurchases()
    }

    func termsOfUseTapped() {
        onTermsOfUse()
    }
}

private extension PaywallViewModel {
    static let defaultBenefits: [PaywallBenefit] = [
        PaywallBenefit(
            id: "speed",
            title: "Get results in seconds",
            icon: .generate
        ),
        PaywallBenefit(
            id: "writing",
            title: "Turn any text into better writing",
            icon: .magicPencil
        ),
        PaywallBenefit(
            id: "simplify",
            title: "Simplify complex information",
            icon: .prompt
        ),
        PaywallBenefit(
            id: "templates",
            title: "Create content with AI templates",
            icon: .magic
        )
    ]

    static let defaultPlans: [PricingPlanItem] = [
        PricingPlanItem(
            id: "year",
            periodLabel: "Year $1.27",
            price: "$ 69.99",
            badgeDiscount: 0.8
        ),
        PricingPlanItem(
            id: "month",
            periodLabel: "Month $1.99",
            price: "$ 7.99",
            badgeDiscount: nil
        )
    ]
}
