//
//  SummaryBadge.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 07.08.2026.
//

import SwiftUI

struct SummaryBadge: View {
    let title: String

    var body: some View {
        Text(key: title)
            .typography(style: .semiBold14)
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.summaryBadge)
            .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: 12) {
        SummaryBadge(title: "Before")
        SummaryBadge(title: "After")
    }
    .padding(24)
    .background(Color.background)
    .environment(LanguageStore.shared)
}
