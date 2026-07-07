//
//  VideoHistoryEmptyState.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 07.07.2026.
//

import SwiftUI

struct VideoHistoryEmptyState: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.background.opacity(0.9),
                    Color.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(spacing: 24) {
                MagicIcon()
                    .fill(AppGradient.main)
                    .frame(width: 50, height: 50)

                VStack(spacing: 12) {
                    Text("No videos yet")
                        .typography(style: .bold28)
                        .foregroundColor(.white)
                        .tracking(0.4)

                    Text("Create your first video to see it here")
                        .typography(style: .regular16)
                        .foregroundColor(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        VideoHistoryEmptyState()
    }
}
