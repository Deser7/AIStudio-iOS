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
    case upload
    case sourceOption
    case functionCard
    case featureCard
}

struct OnboardingTitleSection: View {
    let title: String
    let subtitle: String
    var style: OnboardingTitleSectionStyle = .onboarding

    private var isSourceOptionStyle: Bool {
        style == .sourceOption
    }

    private var isUploadStyle: Bool {
        style == .upload
    }

    private var isFunctionCardStyle: Bool {
        style == .functionCard || style == .featureCard
    }

    private var expandsHorizontally: Bool {
        isUploadStyle || style == .onboarding || isSourceOptionStyle || isFunctionCardStyle
    }

    private var horizontalMaxWidth: CGFloat? {
        expandsHorizontally ? .infinity : nil
    }

    private var hasSubtitle: Bool {
        !subtitle.isEmpty
    }

    private var contentAlignment: HorizontalAlignment {
        isUploadStyle ? .center : .leading
    }

    private var frameAlignment: Alignment {
        isUploadStyle ? .center : .leading
    }

    var body: some View {
        VStack(alignment: contentAlignment, spacing: hasSubtitle ? textSpacing : 0) {
            Text(title)
                .typography(style: titleTypography)
                .tracking(titleTracking)
                .foregroundStyle(titleColor)
                .lineLimit(lineLimit)
                .multilineTextAlignment(isUploadStyle ? .center : .leading)
                .frame(maxWidth: horizontalMaxWidth, alignment: frameAlignment)

            if hasSubtitle, let subtitleTypography {
                Text(subtitle)
                    .typography(style: subtitleTypography)
                    .tracking(subtitleTracking)
                    .foregroundStyle(subtitleColor)
                    .lineLimit(lineLimit)
                    .multilineTextAlignment(isUploadStyle ? .center : .leading)
                    .frame(maxWidth: horizontalMaxWidth, alignment: frameAlignment)
            }
        }
        .frame(maxWidth: horizontalMaxWidth, alignment: frameAlignment)
    }

    private var textSpacing: CGFloat {
        switch style {
        case .onboarding: 8
        case .navigation: 2
        case .upload: 12
        case .sourceOption, .functionCard, .featureCard: 4
        }
    }

    private var titleTypography: Typography.Style {
        switch style {
        case .onboarding: .bold28
        case .navigation, .sourceOption, .featureCard: .semiBold20
        case .upload, .functionCard: .medium16
        }
    }

    private var subtitleTypography: Typography.Style? {
        guard hasSubtitle else { return nil }

        switch style {
        case .onboarding: return .regular16
        case .navigation, .upload, .featureCard: return .regular14
        case .sourceOption: return .regular16
        case .functionCard: return .medium12
        }
    }

    private var titleColor: Color {
        .white
    }

    private var subtitleColor: Color {
        switch style {
        case .onboarding: .price
        case .navigation, .upload: .white.opacity(0.3)
        case .sourceOption, .functionCard: .white.opacity(0.5)
        case .featureCard: .white.opacity(0.7)
        }
    }

    private var titleTracking: CGFloat {
        switch style {
        case .onboarding: 0.4
        case .navigation, .upload, .sourceOption, .functionCard, .featureCard: 0
        }
    }

    private var subtitleTracking: CGFloat {
        style == .functionCard ? -0.08 : 0
    }

    private var lineLimit: Int? {
        style == .navigation ? 1 : nil
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 24) {
        OnboardingTitleSection(
            title: "Title",
            subtitle: "Subtitle here"
        )

        OnboardingTitleSection(
            title: "AI Chat",
            subtitle: "26.03.2026",
            style: .navigation
        )

        OnboardingTitleSection(
            title: "Create stunning images with AI",
            subtitle: "Turn your ideas into art in seconds with powerful generation tools"
        )
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 24)
    .background(Color.background)
}
