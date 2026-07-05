//
//  HomeViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 03.07.2026.
//

import Combine

final class HomeViewModel: ObservableObject {
    let title = "Your AI tools,\nready to go"
    let cacheSize = "5 MB"
    let appVersion = "1.0.0"

    @Published var promptText = ""
    @Published var notificationsEnabled = false

    private let onVideoTap: () -> Void
    private let onWritingTap: () -> Void
    private let onUnderstandTap: () -> Void
    private let onPromptSubmit: () -> Void
    private let onUpgradePlan: () -> Void

    init(
        onVideoTap: @escaping () -> Void = {},
        onWritingTap: @escaping () -> Void = {},
        onUnderstandTap: @escaping () -> Void = {},
        onPromptSubmit: @escaping () -> Void = {},
        onUpgradePlan: @escaping () -> Void = {}
    ) {
        self.onVideoTap = onVideoTap
        self.onWritingTap = onWritingTap
        self.onUnderstandTap = onUnderstandTap
        self.onPromptSubmit = onPromptSubmit
        self.onUpgradePlan = onUpgradePlan
    }

    func videoTapped() {
        onVideoTap()
    }

    func writingTapped() {
        onWritingTap()
    }

    func understandTapped() {
        onUnderstandTap()
    }

    func promptSubmitted() {
        onPromptSubmit()
    }

    func rateAppTapped() {}

    func shareTapped() {}

    func upgradePlanTapped() {
        onUpgradePlan()
    }

    func clearCacheTapped() {}

    func restorePurchasesTapped() {}

    func contactUsTapped() {}

    func privacyPolicyTapped() {}

    func usagePolicyTapped() {}
}
