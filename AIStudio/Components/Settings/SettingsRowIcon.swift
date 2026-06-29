//
//  SettingsRowIcon.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 28.06.2026.
//

import SwiftUI

struct SettingsRowIcon: View {
    let systemName: String

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 17, weight: .regular))
            .foregroundStyle(AppGradient.main)
            .frame(width: 28, height: 22)
    }
}

#Preview {
    SettingsRowIcon(systemName: "star")
}
