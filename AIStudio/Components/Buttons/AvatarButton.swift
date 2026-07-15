//
//  AvatarButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AvatarButton: View {
    var kind: AvatarButtonKind
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.white)

                if kind == .user {
                    UserIcon()
                        .fill(.surface)
                        .frame(width: 16, height: 18)
                }
            }
            .frame(width: 32, height: 32)
        }
        .buttonStyle(.plain)
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
