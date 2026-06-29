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
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.white.opacity(0.4))

            SettingsRowChevron()
        }
    }
}

#Preview {
    SettingsRowDetail(text: "5 MB")
        .frame(width: 100, height: 100)
        .background(.black)

}
