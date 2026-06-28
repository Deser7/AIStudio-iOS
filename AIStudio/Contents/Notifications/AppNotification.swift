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

struct AppNotification: View {
    let content: AppNotificationContent

    private var subtitleColor: Color {
        Color.white.opacity(0.5)
    }

    private var cardHeight: CGFloat {
        switch content {
        case .fileTooLarge: 140
        default: 134
        }
    }

    private var contentSpacing: CGFloat {
        switch content {
        case .fileTooLarge: 12
        default: 8
        }
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        VStack(spacing: contentSpacing) {
            iconView

            textContent
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .frame(width: 239, height: cardHeight)
        .background { notificationBackground }
        .clipShape(shape)
    }

    @ViewBuilder
    private var textContent: some View {
        switch content {
        case .textCopied(let message), .videoSaved(let message):
            Text(message)
                .typography(style: .regular, size: 16)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .frame(height: 38)

        case .fileTooLarge(let title, let subtitle):
            VStack(spacing: 4) {
                Text(title)
                    .typography(style: .semiBold, size: 16)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .frame(height: 19)

                Text(subtitle)
                    .typography(style: .regular, size: 14)
                    .foregroundStyle(subtitleColor)
                    .multilineTextAlignment(.center)
                    .frame(height: 17)
            }
        }
    }

    @ViewBuilder
    private var iconView: some View {
        switch content {
        case .textCopied, .videoSaved:
            CheckIcon()
                .fill(AppGradient.main, style: FillStyle(eoFill: true))
                .frame(width: 40, height: 40)

        case .fileTooLarge:
            CloseIcon()
                .fill(Color.error)
                .frame(width: 40, height: 40)
        }
    }

    private var notificationBackground: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .compact,
                extent: geo.size.height,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.4,
                shape: shape
            )
        }
    }
}

#Preview {
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
    .background(Color.background)
}
