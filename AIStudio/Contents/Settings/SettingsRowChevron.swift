//
//  SettingsRowChevron.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 28.06.2026.
//

import SwiftUI

struct SettingsRowChevron: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(AppGradient.main)
    }
}

#Preview {
    SettingsRowChevron()
}
