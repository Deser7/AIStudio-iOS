//
//  OnboardingTitleSectionStyle.swift
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

    var titleTypography: TypographyStyle {
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

    var subtitleTypography: TypographyStyle {
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
