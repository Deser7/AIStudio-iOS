//
//  CloseButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct CloseButton: View {
    static let defaultSize: CGFloat = 24

    private enum Layout {
        static let iconScale: CGFloat = 16 / 24
    }

    var size: CGFloat = CloseButton.defaultSize
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    private var iconSize: CGFloat { size * Layout.iconScale }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.surface)

                CloseIcon()
                    .fill(Color.accent)
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.6)
    }
}

#Preview("button/close") {
    CloseButton(size: 200) {}
        .padding(24)
        .background(Color.green)
}

#Preview("button/close — scaled") {
    GeometryReader { geo in
        CloseButton(size: geo.size.width * 0.064) {}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
    }
}
