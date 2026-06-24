//
//  OnboardingTitleSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

struct OnboardingTitleSection: View {
    private enum Layout {
        static let textSpacing: CGFloat = 8
        static let titleTracking: CGFloat = 0.4
    }

    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: Layout.textSpacing) {
            Text(title)
                .typography(Typography.bold28)
                .tracking(Layout.titleTracking)
                .foregroundStyle(Color.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(subtitle)
                .typography(Typography.regular16)
                .foregroundStyle(Color.price)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Previews

#Preview("onboardingTitleSection") {
    OnboardingTitleSection(
        title: "Title",
        subtitle: "Subtitle here"
    )
    .padding(.horizontal, 24)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .background(Color.background)
}

#Preview("onboardingTitleSection — multiline") {
    OnboardingTitleSection(
        title: "Create stunning images with AI",
        subtitle: "Turn your ideas into art in seconds with powerful generation tools"
    )
    .padding(.horizontal, 24)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .background(Color.background)
}
