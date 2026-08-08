//
//  UnderstandSummaryCard.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 07.08.2026.
//

import SwiftUI

struct UnderstandSummaryCard<Content: View>: View {
    let badge: String
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SummaryBadge(title: badge)

            Text(title)
                .typography(style: .semiBold20)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            content
                .frame(maxWidth: .infinity)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card)
        .clipShape(AppShape.card)
    }
}

#Preview("Before") {
    UnderstandSummaryCard(badge: "Before", title: "12-page document") {
        DocumentStackPlaceholder()
            .frame(height: 140)
    }
    .padding(16)
    .background(Color.background)
    .environment(LanguageStore.shared)
}

#Preview("After") {
    UnderstandSummaryCard(badge: "After", title: "Key points") {
        SummaryKeyPointsList(
            points: [
                "Following up on a previously sent document",
                "Asking if the recipient had time to review",
                "Requesting feedback and comments",
            ]
        )
    }
    .padding(16)
    .background(Color.background)
    .environment(LanguageStore.shared)
}
