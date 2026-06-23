//
//  AvatarButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AvatarButtonKind {
    case ai
    case user
}

struct AvatarButton: View {
    static let defaultSize: CGFloat = 32

    private enum Layout {
        static let iconScale: CGFloat = 18 / 32
    }

    var size: CGFloat = AvatarButton.defaultSize
    var kind: AvatarButtonKind
    let action: () -> Void

    private var iconSize: CGFloat { size * Layout.iconScale }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.accent)

                iconView
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var iconView: some View {
        switch kind {
        case .ai:
            EmptyView()
        case .user:
            UserIcon()
                .fill(Color.surface)
                .frame(width: iconSize, height: iconSize)
        }
    }
}

#Preview("avatars") {
    VStack(spacing: 16) {
        AvatarButton(size: 200, kind: .ai) {}
        AvatarButton(size: 200, kind: .user) {}
    }
    .padding(24)
    .background(Color.green)
}

#Preview("avatars — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.08

        HStack(spacing: size * 0.5) {
            AvatarButton(size: size, kind: .ai) {}
            AvatarButton(size: size, kind: .user) {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
