//
//  SettingsView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 03.07.2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var notificationsEnabled: Bool
    let cacheSize: String
    let appVersion: String
    let onRateApp: () -> Void
    let onShare: () -> Void
    let onUpgradePlan: () -> Void
    let onClearCache: () -> Void
    let onRestorePurchases: () -> Void
    let onContactUs: () -> Void
    let onPrivacyPolicy: () -> Void
    let onUsagePolicy: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AppGradient.background
                .ignoresSafeArea()

            ScrollView {
                SettingsContents(
                    notificationsEnabled: $notificationsEnabled,
                    cacheSize: cacheSize,
                    appVersion: appVersion,
                    onRateApp: onRateApp,
                    onShare: onShare,
                    onUpgradePlan: onUpgradePlan,
                    onClearCache: onClearCache,
                    onRestorePurchases: onRestorePurchases,
                    onContactUs: onContactUs,
                    onPrivacyPolicy: onPrivacyPolicy,
                    onUsagePolicy: onUsagePolicy
                )
                .padding(.horizontal, 24)
                .padding(.top, 64)
                .padding(.bottom, 24)
            }

            CloseButton(size: 24, style: .surface) {
                dismiss()
            }
                .padding()
        }
    }
}

#Preview {
    SettingsViewPreview()
}

private struct SettingsViewPreview: View {
    @State private var notificationsEnabled = false

    var body: some View {
        SettingsView(
            notificationsEnabled: $notificationsEnabled,
            cacheSize: "5 MB",
            appVersion: "1.0.0",
            onRateApp: {},
            onShare: {},
            onUpgradePlan: {},
            onClearCache: {},
            onRestorePurchases: {},
            onContactUs: {},
            onPrivacyPolicy: {},
            onUsagePolicy: {}
        )
    }
}
