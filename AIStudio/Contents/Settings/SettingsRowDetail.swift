//
//  SettingsRowDetail.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 28.06.2026.
//

import SwiftUI

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
    SettingsRowDetail(text: "GGHHJJ")
}
