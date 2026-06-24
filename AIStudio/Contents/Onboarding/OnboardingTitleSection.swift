//
//  OnboardingTitleSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

enum OnboardingTitleSectionStyle {
    case onboarding
    case navigation
}

struct OnboardingTitleSection: View {
    let title: String
    let subtitle: String
    var style: OnboardingTitleSectionStyle = .onboarding

    private var expandsHorizontally: Bool {
        style == .onboarding
    }

    private var horizontalMaxWidth: CGFloat? {
        expandsHorizontally ? .infinity : nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: textSpacing) {
            Text(title)
                .typography(titleTypography)
                .tracking(titleTracking)
                .foregroundStyle(Color.accent)
                .lineLimit(lineLimit)
                .frame(maxWidth: horizontalMaxWidth, alignment: .leading)

            Text(subtitle)
                .typography(subtitleTypography)
                .foregroundStyle(subtitleColor)
                .lineLimit(lineLimit)
                .frame(maxWidth: horizontalMaxWidth, alignment: .leading)
        }
        .frame(maxWidth: horizontalMaxWidth, alignment: .leading)
    }

    private var textSpacing: CGFloat {
        switch style {
        case .onboarding: 8
        case .navigation: 2
        }
    }

    private var titleTypography: TypographyStyle {
        switch style {
        case .onboarding: Typography.bold28
        case .navigation: Typography.semiBold20
        }
    }

    private var subtitleTypography: TypographyStyle {
        switch style {
        case .onboarding: Typography.regular16
        case .navigation: Typography.regular14
        }
    }

    private var subtitleColor: Color {
        switch style {
        case .onboarding: Color.price
        case .navigation: Color.accent.opacity(AppSurface.CardOpacity.compact)
        }
    }

    private var titleTracking: CGFloat {
        style == .onboarding ? 0.4 : 0
    }

    private var lineLimit: Int? {
        style == .navigation ? 1 : nil
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

#Preview("onboardingTitleSection — navigation") {
    OnboardingTitleSection(
        title: "AI Chat",
        subtitle: "26.03.2026",
        style: .navigation
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
