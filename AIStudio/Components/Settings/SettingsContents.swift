//
//  SettingsContents.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct SettingsContents: View {
    @Binding var notificationsEnabled: Bool
    var cacheSize: String
    var appVersion: String
    var onRateApp: () -> Void
    var onShare: () -> Void
    var onUpgradePlan: () -> Void
    var onClearCache: () -> Void
    var onRestorePurchases: () -> Void
    var onContactUs: () -> Void
    var onPrivacyPolicy: () -> Void
    var onUsagePolicy: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var separatorHeight: CGFloat {
        max(0.33, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            supportSection
            purchasesSection
            infoSection

            Text("App Version: \(appVersion)")
                .typography(style: .regular16)
                .foregroundStyle(Color.price)
                .frame(maxWidth: .infinity)
                .padding(.top, 32)
        }
    }

    private var supportSection: some View {
        SettingsSection(title: "Support us") {
            settingsRow(title: "Rate app", icon: "star", action: onRateApp)

            rowSeparator

            settingsRow(title: "Share with friends", icon: "square.and.arrow.up", action: onShare)
        }
    }

    private var purchasesSection: some View {
        SettingsSection(title: "Purchases & Actions") {
            settingsRow(title: "Upgrade plan", icon: "sparkles", action: onUpgradePlan)

            rowSeparator

            SettingsRow(title: "Notifications") {
                settingsIcon("bell")
            } trailing: {
                AppToggle(isOn: $notificationsEnabled)
            }

            rowSeparator

            SettingsRow(title: "Clear cache", action: onClearCache) {
                settingsIcon("trash")
            } trailing: {
                SettingsRowDetail(text: cacheSize)
            }

            rowSeparator

            settingsRow(title: "Restore purchases", icon: "icloud.and.arrow.down", action: onRestorePurchases)
        }
    }

    private var infoSection: some View {
        SettingsSection(title: "Info & legal") {
            settingsRow(title: "Contact us", icon: "bubble.left", action: onContactUs)

            rowSeparator

            settingsRow(title: "Privacy Policy", icon: "folder", action: onPrivacyPolicy)

            rowSeparator

            settingsRow(title: "Usage Policy", icon: "doc.text", action: onUsagePolicy)
        }
    }

    private func settingsRow(
        title: String,
        icon: String,
        action: @escaping () -> Void
    ) -> some View {
        SettingsRow(title: title, action: action) {
            settingsIcon(icon)
        } trailing: {
            SettingsRowChevron()
        }
    }

    private func settingsIcon(_ systemName: String) -> some View {
        SettingsRowIcon(systemName: systemName)
    }

    private var rowSeparator: some View {
        Color.white.opacity(0.1)
            .frame(height: separatorHeight)
            .padding(.leading, 56)
    }
}

#Preview {
    SettingsContentsPreview()
}

private struct SettingsContentsPreview: View {
    @State private var notificationsEnabled = false

    var body: some View {
        ScrollView {
            SettingsContents(
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
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
        }
        .background(Color.background)
    }
}
