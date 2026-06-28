//
//  SettingsSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Группа строк настроек (Figma grouped `Row`).
struct SettingsSection<Rows: View>: View {
    let title: String
    var width: CGFloat
    @ViewBuilder var rows: () -> Rows

    private var sectionTitleSize: CGFloat { width * 13 / 390 }
    private var titleBottomSpacing: CGFloat { width * 8 / 390 }
    private var groupCornerRadius: CGFloat { width * 12 / 390 }

    var body: some View {
        VStack(alignment: .leading, spacing: titleBottomSpacing) {
            Text(title)
                .typography(style: .regular, size: sectionTitleSize)
                .foregroundStyle(Color.price)
                .textCase(.none)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 0) {
                rows()
            }
            .background(Color.card)
            .clipShape(RoundedRectangle(cornerRadius: groupCornerRadius, style: .continuous))
        }
    }
}

#Preview {
    let size: CGFloat = 390
    let rowHeight = size * 44 / 390

    SettingsSection(title: "Support us", width: size) {
        SettingsRow(title: "Rate app", height: rowHeight, action: {}) {
            SettingsRowIcon(
                systemName: "star",
                width: rowHeight * 28 / 44,
                height: rowHeight * 22 / 44
            )
        }
    }
    .padding(24)
    .background(Color.background)
}
