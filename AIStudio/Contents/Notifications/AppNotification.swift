//
//  AppNotification.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 25.06.2026.
//

import SwiftUI

enum AppNotificationIcon {
    case check
    case close
}

/// Toast-уведомление (Figma «notification»).
struct AppNotification: View {
    static let defaultSize: CGFloat = 239

    let message: String
    var icon: AppNotificationIcon = .check
    var size: CGFloat = AppNotification.defaultSize

    private var horizontalPadding: CGFloat { size * 16 / 239 }
    private var verticalPadding: CGFloat { size * 24 / 239 }
    private var contentSpacing: CGFloat { size * 8 / 239 }
    private var cornerRadius: CGFloat { size * 24 / 239 }
    private var fontSize: CGFloat { size * 16 / 239 }
    private var checkIconWidth: CGFloat { size * 40 / 239 }
    private var checkIconHeight: CGFloat { size * 40 / 239 }
    private var closeIconSize: CGFloat { size * 24 / 239 }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        VStack(spacing: contentSpacing) {
            iconView

            Text(message)
                .font(AppFont.font(weight: .regular, size: fontSize))
                .foregroundStyle(Color.accent)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .frame(width: size)
        .background { notificationBackground }
        .clipShape(shape)
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .check:
            CheckIcon()
                .fill(AppGradient.main, style: FillStyle(eoFill: true))
                .frame(width: checkIconWidth, height: checkIconHeight)
        case .close:
            CloseIcon()
                .fill(AppGradient.main)
                .frame(width: closeIconSize, height: closeIconSize)
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

#Preview("notification — check") {
    AppNotification(
        message: "The text has been copied successfully"
    )
    .padding(24)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.green)
}

#Preview("notification — close") {
    AppNotification(
        message: "Video is saved",
        icon: .close
    )
    .padding(24)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.background)
}

#Preview("notification — scaled") {
    GeometryReader { geo in
        AppNotification(
            message: "The text has been copied successfully",
            size: geo.size.width * 0.6
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
