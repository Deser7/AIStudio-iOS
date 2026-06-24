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
    var size: CGFloat = 32
    var kind: AvatarButtonKind
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.accent)

                if case .user = kind {
                    UserIcon()
                        .fill(Color.surface)
                        .frame(width: size * 18 / 32, height: size * 18 / 32)
                }
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
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
