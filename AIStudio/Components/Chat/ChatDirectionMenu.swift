//
//  ChatDirectionMenu.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 17.07.2026.
//

import SwiftUI

struct ChatDirectionMenu: View {
    let onSelect: (ChatDirection) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(ChatDirection.allCases) { direction in
                AiChatRow(
                    title: direction.title,
                    subtitle: direction.subtitle,
                    action: { onSelect(direction) }
                ) {
                    Logo(
                        size: 40,
                        preset: direction.gradientPreset,
                        icon: direction.logoIcon
                    )
                }
            }
        }
        .clipShape(AppShape.card)
    }
}

#Preview {
    ChatDirectionMenu { _ in }
        .padding(24)
        .background(Color.background)
}
