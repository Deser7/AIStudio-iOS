//
//  SettingsRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct SettingsRow<Icon: View, Trailing: View>: View {
    let title: String
    var action: (() -> Void)?
    @ViewBuilder var icon: () -> Icon
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        Group {
            if let action {
                Button(action: action) {
                    rowContent
                }
                .buttonStyle(.plain)
            } else {
                rowContent
            }
        }
        .appDisabledOpacity()
    }

    private var rowContent: some View {
        HStack(spacing: 12) {
            icon()
                .frame(width: 28, height: 22)

            Text(title)
                .typography(style: .regular16)
                .foregroundStyle(Color.white)
                .tracking(0)
                .lineSpacing(0)
                .frame(maxWidth: .infinity, alignment: .leading)

            trailing()
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

extension SettingsRow where Trailing == SettingsRowChevron {
    init(
        title: String,
        action: (() -> Void)? = nil,
        @ViewBuilder icon: @escaping () -> Icon
    ) {
        self.title = title
        self.action = action
        self.icon = icon
        self.trailing = { SettingsRowChevron() }
    }
}

struct SettingsRowChevron: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(AppGradient.main)
    }
}

struct SettingsRowDetail: View {
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Text(text)
                .typography(style: .regular16)
                .foregroundStyle(Color.price)

            SettingsRowChevron()
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingsRow(title: "Rate app", action: {}) {
            SettingsRowIcon(systemName: "star")
        }

        SettingsRow(title: "Notifications") {
            SettingsRowIcon(systemName: "bell")
        } trailing: {
            AppToggle(height: 31, isOn: .constant(true))
        }

        SettingsRow(title: "Clear cache", action: {}) {
            SettingsRowIcon(systemName: "trash")
        } trailing: {
            SettingsRowDetail(text: "5 MB")
        }
    }
    .background(Color.card)
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    .padding(24)
    .background(Color.background)
}
