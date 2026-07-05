//
//  HistoryEmptyState.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct HistoryEmptyState: View {
    var body: some View {
        VStack(spacing: 24) {
            MagicPencil()
                .fill(AppGradient.main)
                .frame(width: 60, height: 60)

            VStack(spacing: 12) {
                Text("No chats yet")
                    .typography(style: .bold28)
                    .foregroundColor(.white)
                    .tracking(0.4)

                Text("Start a conversation to see your history here")
                    .typography(style: .regular16)
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        HistoryEmptyState()
    }
}
