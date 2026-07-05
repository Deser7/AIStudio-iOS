//
//  ChatEmptyState.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import SwiftUI

struct ChatEmptyState: View {
    var body: some View {
        VStack(spacing: 12) {
            title
            subtitle
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
    }

    private var title: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Your ")
                    .foregroundColor(.white)

                gradientText("AI assistant")
            }

            Text("for anything")
                .foregroundColor(.white)
        }
        .typography(style: .bold28)
        .tracking(0.4)
    }

    private var subtitle: some View {
        Text("Ask questions, get answers, and explore ideas in seconds")
            .typography(style: .regular14)
            .foregroundColor(.price)
    }

    private func gradientText(_ string: String) -> some View {
        Text(string)
            .foregroundColor(.clear)
            .background(AppGradient.main)
            .mask {
                Text(string)
            }
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        ChatEmptyState()
    }
}
