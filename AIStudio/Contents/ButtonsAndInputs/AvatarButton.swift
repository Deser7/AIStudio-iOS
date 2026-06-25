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
    var size: CGFloat
    var kind: AvatarButtonKind
    let action: () -> Void

    private var iconSize: CGFloat { size * 0.5625 }

    private var showsUserIcon: Bool {
        if case .user = kind { true } else { false }
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.accent)

                if showsUserIcon {
                    userIcon
                }
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }

    private var userIcon: some View {
        UserIcon()
            .fill(Color.surface)
            .frame(width: iconSize, height: iconSize)
    }
}

#Preview {
    let size: CGFloat = 32

    HStack(spacing: size * 0.5) {
        AvatarButton(size: size, kind: .ai) {}
        AvatarButton(size: size, kind: .user) {}
    }
    .padding(24)
    .background(Color.background)
}
