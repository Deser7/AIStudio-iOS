//
//  OnboardingTitleSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

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
