//
//  SettingsRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct SettingsRowIcon: View {
    let systemName: String
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: min(width, height), weight: .medium))
            .foregroundStyle(AppGradient.main)
            .frame(width: width, height: height)
    }
}

/// Строка настроек (Figma «Row», height Hug 44).
struct SettingsRow<Icon: View, Trailing: View>: View {
    let title: String
    var size: CGFloat
    var action: (() -> Void)?
    @ViewBuilder var icon: () -> Icon
    @ViewBuilder var trailing: () -> Trailing

    @Environment(\.displayScale) private var displayScale

    private var fontSize: CGFloat { size * 16 / 44 }
    private var iconWidth: CGFloat { size * 28 / 44 }
    private var iconHeight: CGFloat { size * 22 / 44 }
    private var contentSpacing: CGFloat { size * 12 / 44 }
    private var horizontalPadding: CGFloat { size * 16 / 44 }

    var body: some View {
        Group {
            if let action {
                Button(action: action) {
                    rowContent
                }
                .buttonStyle(.plain)
            } else {
                rowContent
            }
        }
        .appDisabledOpacity()
    }

    private var rowContent: some View {
        HStack(spacing: contentSpacing) {
            icon()
                .frame(width: iconWidth, height: iconHeight)

            Text(title)
                .font(AppFont.font(weight: .regular, size: fontSize))
                .foregroundStyle(Color.white)
                .tracking(0)
                .lineSpacing(0)
                .frame(maxWidth: .infinity, alignment: .leading)

            trailing()
        }
        .padding(.horizontal, horizontalPadding)
        .frame(height: size)
    }
}

extension SettingsRow where Trailing == SettingsRowChevron {
    init(
        title: String,
        size: CGFloat,
        action: (() -> Void)? = nil,
        @ViewBuilder icon: @escaping () -> Icon
    ) {
        self.title = title
        self.size = size
        self.action = action
        self.icon = icon
        self.trailing = { SettingsRowChevron(size: size) }
    }
}

struct SettingsRowChevron: View {
    var size: CGFloat

    private var chevronSize: CGFloat { size * 14 / 44 }

    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: chevronSize, weight: .semibold))
            .foregroundStyle(AppGradient.main)
    }
}

struct SettingsRowDetail: View {
    let text: String
    var size: CGFloat

    private var fontSize: CGFloat { size * 16 / 44 }
    private var detailSpacing: CGFloat { size * 8 / 44 }

    var body: some View {
        HStack(spacing: detailSpacing) {
            Text(text)
                .font(AppFont.font(weight: .regular, size: fontSize))
                .foregroundStyle(Color.price)

            SettingsRowChevron(size: size)
        }
    }
}

#Preview {
    let size: CGFloat = 44

    VStack(spacing: 0) {
        SettingsRow(title: "Rate app", size: size, action: {}) {
            SettingsRowIcon(systemName: "star", width: size * 28 / 44, height: size * 22 / 44)
        }

        SettingsRow(title: "Notifications", size: size) {
            SettingsRowIcon(systemName: "bell", width: size * 28 / 44, height: size * 22 / 44)
        } trailing: {
            AppToggle(size: size * 31 / 44, isOn: .constant(true))
        }

        SettingsRow(title: "Clear cache", size: size, action: {}) {
            SettingsRowIcon(systemName: "trash", width: size * 28 / 44, height: size * 22 / 44)
        } trailing: {
            SettingsRowDetail(text: "5 MB", size: size)
        }
    }
    .background(Color.card)
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    .padding(24)
    .background(Color.background)
}
