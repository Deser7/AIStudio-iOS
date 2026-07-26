//
//  ChatDirectionMenu.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 17.07.2026.
//

import SwiftUI

struct ChatDirectionMenu: View {
    let onSelect: (ChatDirection) -> Void

    private let rowHeight: CGFloat = 72
    private let maxVisibleRows: CGFloat = 6

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(ChatDirection.allCases) { direction in
                    AiChatRow(
                        title: direction.title,
                        subtitle: direction.subtitle
                    ) {
                        onSelect(direction)
                    } icon: {
                        Logo(
                            size: 40,
                            preset: direction.logoPreset,
                            icon: direction.logoIcon
                        )
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .frame(maxHeight: menuMaxHeight)
        .clipShape(AppShape.card)
    }

    private var menuMaxHeight: CGFloat {
        let contentHeight = CGFloat(ChatDirection.allCases.count) * rowHeight
        return min(contentHeight, rowHeight * maxVisibleRows)
    }
}

#Preview {
    ChatDirectionMenu { _ in }
        .padding(24)
        .background(Color.background)
}
