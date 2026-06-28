//
//  SettingsSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Группа строк настроек (Figma grouped `Row`, ref 390).
struct SettingsSection<Rows: View>: View {
    let title: String
    @ViewBuilder var rows: () -> Rows

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .typography(style: .regular16)
                .foregroundStyle(Color.price)
                .textCase(.none)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 0) {
                rows()
            }
            .background(Color.card)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

#Preview {
    SettingsSection(title: "Support us") {
        SettingsRow(title: "Rate app", action: {}) {
            SettingsRowIcon(systemName: "star")
        } trailing: {
            SettingsRowChevron()
        }
    }
    .padding(24)
    .background(Color.background)
}
