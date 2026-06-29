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
    var kind: AvatarButtonKind
    let action: () -> Void

    private var showsUserIcon: Bool {
        if case .user = kind { true } else { false }
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.white)

                if showsUserIcon {
                    userIcon
                }
            }
            .frame(width: 32, height: 32)
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }

    private var userIcon: some View {
        UserIcon()
            .fill(.surface)
            .frame(width: 16, height: 18)
    }
}

#Preview {
    HStack(spacing: 16) {
        AvatarButton(kind: .ai, action: {})
        AvatarButton(kind: .user, action: {})
    }
    .padding(24)
    .background(Color.background)
}
