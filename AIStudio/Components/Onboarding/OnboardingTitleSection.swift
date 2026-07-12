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

extension OnboardingTitleSectionStyle {

    var spacing: CGFloat {
        switch self {
        case .onboarding: 8
        case .navigation: 2
        case .upload: 12
        case .sourceOption, .functionCard, .featureCard: 4
        }
    }

    var titleTypography: Typography.Style {
        switch self {
        case .onboarding:
            .bold28

        case .navigation,
             .sourceOption,
             .featureCard:
            .semiBold20

        case .upload,
             .functionCard:
            .medium16
        }
    }

    var subtitleTypography: Typography.Style {
        switch self {
        case .onboarding:
            .regular16

        case .navigation,
             .upload,
             .featureCard:
            .regular14

        case .sourceOption:
            .regular16

        case .functionCard:
            .medium12
        }
    }

    var subtitleColor: Color {
        switch self {
        case .onboarding:
            .price

        case .navigation,
             .upload:
            .white.opacity(0.3)

        case .sourceOption,
             .functionCard:
            .white.opacity(0.5)

        case .featureCard:
            .white.opacity(0.7)
        }
    }

    var titleTracking: CGFloat {
        self == .onboarding ? 0.4 : 0
    }

    var subtitleTracking: CGFloat {
        self == .functionCard ? -0.08 : 0
    }

    var lineLimit: Int? {
        self == .navigation ? 1 : nil
    }

    var horizontalAlignment: HorizontalAlignment {
        self == .upload ? .center : .leading
    }

    var frameAlignment: Alignment {
        self == .upload ? .center : .leading
    }

    var expandsHorizontally: Bool {
        switch self {
        case .navigation:
            false

        case .onboarding,
             .upload,
             .sourceOption,
             .functionCard,
             .featureCard:
            true
        }
    }
}

struct OnboardingTitleSection: View {
    let title: String
    let subtitle: String

    var style: OnboardingTitleSectionStyle = .onboarding

    private var hasSubtitle: Bool {
        !subtitle.isEmpty
    }

    var body: some View {
        VStack(
            alignment: style.horizontalAlignment,
            spacing: hasSubtitle ? style.spacing : 0
        ) {
            Text(key: title)
                .typography(style: style.titleTypography)
                .tracking(style.titleTracking)
                .foregroundStyle(.white)
                .lineLimit(style.lineLimit)
                .multilineTextAlignment(style == .upload ? .center : .leading)
                .frame(
                    maxWidth: style.expandsHorizontally ? .infinity : nil,
                    alignment: style.frameAlignment
                )

            if hasSubtitle {
                Text(key: subtitle)
                    .typography(style: style.subtitleTypography)
                    .tracking(style.subtitleTracking)
                    .foregroundStyle(style.subtitleColor)
                    .lineLimit(style.lineLimit)
                    .multilineTextAlignment(style == .upload ? .center : .leading)
                    .frame(
                        maxWidth: style.expandsHorizontally ? .infinity : nil,
                        alignment: style.frameAlignment
                    )
            }
        }
        .frame(
            maxWidth: style.expandsHorizontally ? .infinity : nil,
            alignment: style.frameAlignment
        )
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
    .padding(24)
    .background(Color.background)
}
