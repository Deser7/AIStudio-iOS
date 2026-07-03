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

    var body: some View {
        VStack(spacing: contentSpacing) {
            iconView

            textContent
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .frame(width: 239, height: cardHeight)
        .background(CardBlurBackground(opacity: 0.4))
        .clipShape(AppShape.card)
    }

    @ViewBuilder
    private var textContent: some View {
        switch content {
        case .textCopied(let message), .videoSaved(let message):
            Text(message)
                .typography(style: .regular16)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

        case let .fileTooLarge(title, subtitle):
            VStack(spacing: 4) {
                Text(title)
                    .typography(style: .semiBold16)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text(subtitle)
                    .typography(style: .regular14)
                    .foregroundStyle(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
            }
        }
    }

    @ViewBuilder
    private var iconView: some View {
        let iconSize: CGFloat = 40
        
        switch content {
        case .textCopied, .videoSaved:
            CheckIcon()
                .fill(AppGradient.main)
                .frame(width: iconSize, height: iconSize)

        case .fileTooLarge:
            CloseIcon()
                .fill(.error)
                .frame(width: iconSize, height: iconSize)
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
    .background(.red)
}
