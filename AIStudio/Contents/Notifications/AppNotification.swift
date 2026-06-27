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
    let content: AppNotificationContent
    var size: CGFloat

    private var titleFontSize: CGFloat { size * 16 / 239 }
    private var cornerRadius: CGFloat { size * 24 / 239 }
    private var successContentSpacing: CGFloat { size * 8 / 239 }
    private var errorContentSpacing: CGFloat { size * 12 / 239 }
    private var titleSubtitleSpacing: CGFloat { size * 4 / 239 }
    private var subtitleFontSize: CGFloat { size * 14 / 239 }
    private var iconSize: CGFloat { size * 40 / 239 }
    private var messageTextHeight: CGFloat { size * 38 / 239 }
    private var errorTitleHeight: CGFloat { size * 19 / 239 }
    private var errorSubtitleHeight: CGFloat { size * 17 / 239 }
    private var blurRadius: CGFloat { size * AppSurface.blurRadius / 239 }

    private var cardHeight: CGFloat {
        switch content {
        case .fileTooLarge:
            size * 140 / 239
        default:
            size * 134 / 239
        }
    }

    private var subtitleColor: Color {
        Color.white.opacity(0.5)
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
        .padding(.horizontal, titleFontSize)
        .padding(.vertical, cornerRadius)
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
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .frame(height: messageTextHeight)

        case .fileTooLarge(let title, let subtitle):
            VStack(spacing: titleSubtitleSpacing) {
                Text(title)
                    .font(AppFont.font(weight: .semiBold, size: titleFontSize))
                    .foregroundStyle(Color.white)
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
                .frame(width: iconSize, height: iconSize)

        case .fileTooLarge:
            CloseIcon()
                .fill(Color.error)
                .frame(width: iconSize, height: iconSize)
        }
    }

    private var notificationBackground: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .compact,
                size: geo.size.height,
                blurRadius: blurRadius,
                cardOpacity: 0.4,
                shape: shape
            )
        }
    }
}

#Preview {
    let size: CGFloat = 239

    VStack(spacing: 24) {
        AppNotification(
            content: .textCopied(
                message: "The text has been copied successfully"
            ),
            size: size
        )

        AppNotification(
            content: .videoSaved(
                message: "Video has been saved to your gallery"
            ),
            size: size
        )

        AppNotification(
            content: .fileTooLarge(
                title: "File is too large",
                subtitle: "Maximum file size is 100 MB"
            ),
            size: size
        )
    }
    .padding(24)
    .background(Color.background)
}
