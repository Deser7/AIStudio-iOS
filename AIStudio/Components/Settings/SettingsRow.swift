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
                .foregroundStyle(.white)
                .tracking(0)
                .lineSpacing(0)
                .frame(maxWidth: .infinity, alignment: .leading)

            trailing()
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingsRow(title: "Rate app", action: {}) {
            SettingsRowIcon(systemName: "star")
        } trailing: {
            SettingsRowChevron()
        }

        SettingsRow(title: "Notifications") {
            SettingsRowIcon(systemName: "bell")
        } trailing: {
            AppToggle(isOn: .constant(true))
        }

        SettingsRow(title: "Clear cache", action: {}) {
            SettingsRowIcon(systemName: "trash")
        } trailing: {
            SettingsRowDetail(text: "5 MB")
        }
    }
    .background(.card)
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    .padding(24)
    .background(Color.background)
}
