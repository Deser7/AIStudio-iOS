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
    /// Figma «AI Text» / «Understand Faster».
    case functionCard
    /// Figma «AI Video».
    case featureCard
}

struct OnboardingTitleSection: View {
    let title: String
    let subtitle: String
    var style: OnboardingTitleSectionStyle = .onboarding
    /// Базовая единица 16 px для `.upload`.
    var textSize: CGFloat = 16
    /// Title 20 px для `.sourceOption`.
    var titleTextSize: CGFloat?

    /// Subtitle 14 px для `.upload`, 16 px для `.sourceOption`.
    var subtitleTextSize: CGFloat?

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
                .typography(titleTypography)
                .tracking(titleTracking)
                .foregroundStyle(titleColor)
                .lineLimit(lineLimit)
                .multilineTextAlignment(isUploadStyle ? .center : .leading)
                .frame(maxWidth: horizontalMaxWidth, alignment: frameAlignment)

            if hasSubtitle {
                Text(subtitle)
                    .typography(subtitleTypography)
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
        case .upload: textSize * 12 / 16
        case .sourceOption: sourceOptionTitleSize * 4 / 20
        case .functionCard: functionCardTitleSize * 4 / 16
        case .featureCard: featureCardTitleSize * 4 / 20
        }
    }

    private var functionCardTitleSize: CGFloat {
        titleTextSize ?? textSize
    }

    private var featureCardTitleSize: CGFloat {
        titleTextSize ?? textSize
    }

    private var sourceOptionTitleSize: CGFloat {
        titleTextSize ?? textSize
    }

    private var titleTypography: TypographyStyle {
        switch style {
        case .onboarding: Typography.bold28
        case .navigation: Typography.semiBold20
        case .upload: Typography.medium(size: textSize)
        case .sourceOption: Typography.semiBold(size: sourceOptionTitleSize)
        case .functionCard: Typography.medium(size: functionCardTitleSize)
        case .featureCard: Typography.medium(size: featureCardTitleSize)
        }
    }

    private var subtitleTypography: TypographyStyle {
        switch style {
        case .onboarding: Typography.regular16
        case .navigation: Typography.regular14
        case .upload: Typography.regular(size: uploadSubtitleSize)
        case .sourceOption: Typography.regular(size: sourceOptionSubtitleSize)
        case .functionCard: Typography.medium(size: functionCardSubtitleSize)
        case .featureCard: Typography.regular(size: featureCardSubtitleSize)
        }
    }

    private var functionCardSubtitleSize: CGFloat {
        subtitleTextSize ?? functionCardTitleSize * 12 / 16
    }

    private var featureCardSubtitleSize: CGFloat {
        subtitleTextSize ?? featureCardTitleSize * 14 / 20
    }

    private var uploadSubtitleSize: CGFloat {
        subtitleTextSize ?? textSize * 14 / 16
    }

    private var sourceOptionSubtitleSize: CGFloat {
        subtitleTextSize ?? sourceOptionTitleSize * 16 / 20
    }

    private var titleColor: Color {
        Color.white
    }

    private var subtitleColor: Color {
        switch style {
        case .onboarding: Color.price
        case .navigation: Color.white.opacity(0.3)
        case .upload: Color.white.opacity(0.3)
        case .sourceOption: Color.white.opacity(0.5)
        case .functionCard: Color.white.opacity(0.5)
        case .featureCard: Color.white.opacity(0.7)
        }
    }

    private var titleTracking: CGFloat {
        switch style {
        case .onboarding: 0.4
        case .navigation, .upload, .sourceOption, .functionCard, .featureCard: 0
        }
    }

    private var subtitleTracking: CGFloat {
        switch style {
        case .functionCard: functionCardSubtitleSize * AppSurface.FunctionCard.subtitleLetterSpacing / 12
        case .featureCard, .onboarding, .navigation, .upload, .sourceOption: 0
        }
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
