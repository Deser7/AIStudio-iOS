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
}

struct OnboardingTitleSection: View {
    let title: String
    let subtitle: String
    var style: OnboardingTitleSectionStyle = .onboarding
    /// Базовая единица 16 px для `.upload`.
    var textSize: CGFloat = 16
    /// Subtitle 14 px для `.upload`.
    var subtitleTextSize: CGFloat?

    private var isUploadStyle: Bool {
        style == .upload
    }

    private var expandsHorizontally: Bool {
        isUploadStyle || style == .onboarding
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
                .foregroundStyle(Color.accent)
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
        }
    }

    private var titleTypography: TypographyStyle {
        switch style {
        case .onboarding: Typography.bold28
        case .navigation: Typography.semiBold20
        case .upload: Typography.medium(size: textSize)
        }
    }

    private var subtitleTypography: TypographyStyle {
        switch style {
        case .onboarding: Typography.regular16
        case .navigation: Typography.regular14
        case .upload: Typography.regular(size: uploadSubtitleSize)
        }
    }

    private var uploadSubtitleSize: CGFloat {
        subtitleTextSize ?? textSize * 14 / 16
    }

    private var subtitleColor: Color {
        switch style {
        case .onboarding: Color.price
        case .navigation: Color.accent.opacity(AppSurface.Interaction.subtitleOpacity)
        case .upload: Color.accent.opacity(AppSurface.Interaction.subtitleOpacity)
        }
    }

    private var titleTracking: CGFloat {
        switch style {
        case .onboarding: 0.4
        case .navigation, .upload: 0
        }
    }

    private var subtitleTracking: CGFloat { 0 }

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
