//
//  SettingsContents.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Контент экрана настроек (Figma «SettingsContents»).
struct SettingsContents: View {
    var size: CGFloat
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

    private var rowHeight: CGFloat { size * 44 / 390 }
    private var sectionSpacing: CGFloat { size * 24 / 390 }
    private var footerTopSpacing: CGFloat { size * 32 / 390 }
    private var footerFontSize: CGFloat { size * 12 / 390 }
    private var iconWidth: CGFloat { rowHeight * 28 / 44 }
    private var iconHeight: CGFloat { rowHeight * 22 / 44 }
    private var toggleSize: CGFloat { rowHeight * 31 / 44 }
    private var separatorInset: CGFloat { size * 56 / 390 }

    @Environment(\.displayScale) private var displayScale

    private var separatorHeight: CGFloat {
        max(size * 0.33 / 390, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: sectionSpacing) {
            supportSection
            purchasesSection
            infoSection

            Text("App Version: \(appVersion)")
                .font(AppFont.font(weight: .regular, size: footerFontSize))
                .foregroundStyle(Color.price)
                .frame(maxWidth: .infinity)
                .padding(.top, footerTopSpacing)
        }
    }

    private var supportSection: some View {
        SettingsSection(title: "Support us", size: size) {
            settingsRow(title: "Rate app", icon: "star", action: onRateApp)

            rowSeparator

            settingsRow(title: "Share with friends", icon: "square.and.arrow.up", action: onShare)
        }
    }

    private var purchasesSection: some View {
        SettingsSection(title: "Purchases & Actions", size: size) {
            settingsRow(title: "Upgrade plan", icon: "sparkles", action: onUpgradePlan)

            rowSeparator

            SettingsRow(title: "Notifications", size: rowHeight) {
                settingsIcon("bell")
            } trailing: {
                AppToggle(size: toggleSize, isOn: $notificationsEnabled)
            }

            rowSeparator

            SettingsRow(title: "Clear cache", size: rowHeight, action: onClearCache) {
                settingsIcon("trash")
            } trailing: {
                SettingsRowDetail(text: cacheSize, size: rowHeight)
            }

            rowSeparator

            settingsRow(title: "Restore purchases", icon: "icloud.and.arrow.down", action: onRestorePurchases)
        }
    }

    private var infoSection: some View {
        SettingsSection(title: "Info & legal", size: size) {
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
        SettingsRow(title: title, size: rowHeight, action: action) {
            settingsIcon(icon)
        }
    }

    private func settingsIcon(_ systemName: String) -> some View {
        SettingsRowIcon(systemName: systemName, width: iconWidth, height: iconHeight)
    }

    private var rowSeparator: some View {
        Color.white.opacity(AppSurface.Interaction.faintOpacity)
            .frame(height: separatorHeight)
            .padding(.leading, separatorInset)
    }
}

#Preview {
    SettingsContentsPreview()
}

private struct SettingsContentsPreview: View {
    @State private var notificationsEnabled = false

    var body: some View {
        let size: CGFloat = 390

        ScrollView {
            SettingsContents(
                size: size,
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
