//
//  ChatNavigationBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

enum ChatNavigationBarStyle {
    /// Logo + title + subtitle + regenerate.
    case aiChat
    /// MagicIcon + title + regenerate.
    case aiVideo
    /// Title по центру, без иконки и regenerate.
    case centeredTitle
}

struct ChatNavigationBar: View {
    let title: String
    var subtitle: String = ""
    var style: ChatNavigationBarStyle = .aiChat
    var preset = AppGradient.Preset.blue
    let onBack: () -> Void
    var onRegenerate: (() -> Void)?

    private let contentSpacing: CGFloat = 10
    private let horizontalPadding: CGFloat = 16
    private let barHeight: CGFloat = 75
    private let leadingIconSize: CGFloat = 32
    private let leadingIconContentSize: CGFloat = 32 * 0.6125
    private let regenerateIconSize: CGFloat = 24
    private let actionTapSize: CGFloat = 44
    private let backIconSize: CGFloat = 17
    private let borderHeight: CGFloat = 0.5

    private var borderColor: Color {
        Color.accent.opacity(0.1)
    }

    private var showsRegenerateButton: Bool {
        style != .centeredTitle && onRegenerate != nil
    }

    var body: some View {
        Group {
            switch style {
            case .centeredTitle:
                centeredContent
            case .aiChat, .aiVideo:
                leadingContent
            }
        }
        .padding(.horizontal, horizontalPadding)
        .frame(maxWidth: .infinity)
        .frame(height: barHeight)
        .background { background }
        .overlay(alignment: .bottom) { bottomBorder }
    }

    private var leadingContent: some View {
        HStack(spacing: contentSpacing) {
            backButton

            HStack(spacing: contentSpacing) {
                leadingIcon

                titleSection
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: contentSpacing)

            if showsRegenerateButton {
                regenerateButton
            }
        }
    }

    private var centeredContent: some View {
        ZStack {
            HStack {
                backButton

                Spacer(minLength: 0)

                Color.clear
                    .frame(width: actionTapSize, height: actionTapSize)
            }

            Text(title)
                .typography(Typography.semiBold20)
                .foregroundStyle(Color.accent)
                .lineLimit(1)
        }
    }

    @ViewBuilder
    private var leadingIcon: some View {
        switch style {
        case .aiChat:
            Logo(size: leadingIconSize, preset: preset)
        case .aiVideo:
            gradientLeadingIcon {
                MagicIcon()
                    .fill(Color.accent)
            }
        case .centeredTitle:
            EmptyView()
        }
    }

    @ViewBuilder
    private var titleSection: some View {
        switch style {
        case .aiChat:
            OnboardingTitleSection(
                title: title,
                subtitle: subtitle,
                style: .navigation
            )
        case .aiVideo:
            Text(title)
                .typography(Typography.semiBold20)
                .foregroundStyle(Color.accent)
                .lineLimit(1)
        case .centeredTitle:
            EmptyView()
        }
    }

    private func gradientLeadingIcon<Icon: View>(
        @ViewBuilder icon: () -> Icon
    ) -> some View {
        ZStack {
            AppGradient.linear(preset)
                .frame(width: leadingIconSize, height: leadingIconSize)
                .clipShape(Circle())

            icon()
                .frame(width: leadingIconContentSize, height: leadingIconContentSize)
        }
    }

    private var backButton: some View {
        Button(action: onBack) {
            Image(systemName: "chevron.left")
                .font(.system(size: backIconSize, weight: .semibold))
                .foregroundStyle(Color.accent)
                .frame(width: actionTapSize, height: actionTapSize, alignment: .leading)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Back"))
    }

    private var regenerateButton: some View {
        Button(action: { onRegenerate?() }) {
            RegenerateIcon()
                .fill(Color.accent)
                .frame(width: regenerateIconSize, height: regenerateIconSize)
                .frame(width: actionTapSize, height: actionTapSize)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Regenerate"))
    }

    private var background: some View {
        ZStack {
            BackdropBlurView()

            Color.card.opacity(AppSurface.CardOpacity.compact)
        }
    }

    private var bottomBorder: some View {
        Rectangle()
            .fill(borderColor)
            .frame(height: borderHeight)
    }
}

#Preview {
    VStack(spacing: 0) {
        ChatNavigationBar(
            title: "AI Chat",
            subtitle: "26.03.2026",
            style: .aiChat,
            preset: .main,
            onBack: {},
            onRegenerate: {}
        )

        ChatNavigationBar(
            title: "AI Chat",
            subtitle: "26.03.2026",
            style: .aiChat,
            preset: .blue,
            onBack: {},
            onRegenerate: {}
        )

        ChatNavigationBar(
            title: "AI Video",
            style: .aiVideo,
            preset: .main,
            onBack: {},
            onRegenerate: {}
        )

        ChatNavigationBar(
            title: "Settings",
            style: .centeredTitle,
            onBack: {}
        )

        ChatNavigationBar(
            title: "Clay Fool",
            style: .centeredTitle,
            onBack: {}
        )

        Spacer()
    }
    .background(Color.background)
}
