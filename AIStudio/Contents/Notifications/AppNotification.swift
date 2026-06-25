//
//  AppNotification.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 25.06.2026.
//

import SwiftUI

enum AppNotificationContent {
    case textCopied(message: String)
    case videoSaved(message: String)
    case fileTooLarge(title: String, subtitle: String)
}

/// Toast-уведомление (Figma «notification»).
struct AppNotification: View {
    static let defaultSize: CGFloat = 239

    private static let successHeight: CGFloat = 134
    private static let errorHeight: CGFloat = 140

    let content: AppNotificationContent
    var size: CGFloat = AppNotification.defaultSize

    private var horizontalPadding: CGFloat { size * 16 / 239 }
    private var verticalPadding: CGFloat { size * 24 / 239 }
    private var successContentSpacing: CGFloat { size * 8 / 239 }
    private var errorContentSpacing: CGFloat { size * 12 / 239 }
    private var titleSubtitleSpacing: CGFloat { size * 4 / 239 }
    private var cornerRadius: CGFloat { size * 24 / 239 }
    private var titleFontSize: CGFloat { size * 16 / 239 }
    private var subtitleFontSize: CGFloat { size * 14 / 239 }
    private var checkIconWidth: CGFloat { size * 40 / 239 }
    private var checkIconHeight: CGFloat { size * 40 / 239 }
    private var errorCloseIconSize: CGFloat { size * 40 / 239 }
    private var messageTextHeight: CGFloat { size * 38 / 239 }
    private var errorTitleHeight: CGFloat { size * 19 / 239 }
    private var errorSubtitleHeight: CGFloat { size * 17 / 239 }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }

    private var cardHeight: CGFloat {
        switch content {
        case .fileTooLarge:
            size * Self.errorHeight / Self.defaultSize
        default:
            size * Self.successHeight / Self.defaultSize
        }
    }

    private var subtitleColor: Color {
        Color.accent.opacity(AppSurface.Interaction.notificationSubtitleOpacity)
    }

    private var contentSpacing: CGFloat {
        switch content {
        case .fileTooLarge: errorContentSpacing
        default: successContentSpacing
        }
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        VStack(spacing: contentSpacing) {
            iconView

            textContent
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .frame(width: size, height: cardHeight)
        .background { notificationBackground }
        .clipShape(shape)
    }

    @ViewBuilder
    private var textContent: some View {
        switch content {
        case .textCopied(let message), .videoSaved(let message):
            Text(message)
                .font(AppFont.font(weight: .regular, size: titleFontSize))
                .foregroundStyle(Color.accent)
                .multilineTextAlignment(.center)
                .frame(height: messageTextHeight)

        case .fileTooLarge(let title, let subtitle):
            VStack(spacing: titleSubtitleSpacing) {
                Text(title)
                    .font(AppFont.font(weight: .semiBold, size: titleFontSize))
                    .foregroundStyle(Color.accent)
                    .multilineTextAlignment(.center)
                    .frame(height: errorTitleHeight)

                Text(subtitle)
                    .font(AppFont.font(weight: .regular, size: subtitleFontSize))
                    .foregroundStyle(subtitleColor)
                    .multilineTextAlignment(.center)
                    .frame(height: errorSubtitleHeight)
            }
        }
    }

    @ViewBuilder
    private var iconView: some View {
        switch content {
        case .textCopied, .videoSaved:
            CheckIcon()
                .fill(AppGradient.main, style: FillStyle(eoFill: true))
                .frame(width: checkIconWidth, height: checkIconHeight)

        case .fileTooLarge:
            CloseIcon()
                .fill(Color.errorIcon)
                .frame(width: errorCloseIconSize, height: errorCloseIconSize)
        }
    }

    private var notificationBackground: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .compact,
                size: geo.size.height,
                blurRadius: blurRadius,
                cardOpacity: AppSurface.CardOpacity.compact,
                shape: shape
            )
        }
    }
}

#Preview("notification — all variants") {
    VStack(spacing: 24) {
        AppNotification(
            content: .textCopied(
                message: "The text has been copied successfully"
            )
        )

        AppNotification(
            content: .videoSaved(
                message: "Video has been saved to your gallery"
            )
        )

        AppNotification(
            content: .fileTooLarge(
                title: "File is too large",
                subtitle: "Maximum file size is 100 MB"
            )
        )
    }
    .padding(24)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.green)
}

#Preview("notification — scaled") {
    GeometryReader { geo in
        AppNotification(
            content: .videoSaved(
                message: "Video has been saved to your gallery"
            ),
            size: geo.size.width * 0.6
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
