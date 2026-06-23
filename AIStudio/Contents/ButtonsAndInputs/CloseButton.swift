//
//  CloseButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct CloseButton: View {
    enum Style {
        case surface
        case light
    }

    static let defaultSize: CGFloat = 24

    private enum Layout {
        static let iconScale: CGFloat = 16 / 24
    }

    var size: CGFloat = CloseButton.defaultSize
    var style: Style = .surface
    let action: () -> Void

    private var iconSize: CGFloat { size * Layout.iconScale }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(backgroundColor)

                iconView
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var iconView: some View {
        switch style {
        case .surface:
            CloseIcon()
                .fill(Color.accent)
        case .light:
            CloseIcon()
                .fill(AppGradient.main)
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .surface:
            return .surface
        case .light:
            return .accent
        }
    }
}

#Preview("button/close") {
    HStack(spacing: 24) {
        CloseButton(style: .surface) {}
        CloseButton(style: .light) {}
    }
    .padding(24)
    .background(Color.background)
}

#Preview("button/close — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.064

        HStack(spacing: size) {
            CloseButton(size: size, style: .surface) {}
            CloseButton(size: size, style: .light) {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
