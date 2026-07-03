//
//  AIResponseIndicator.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

struct AIResponseIndicator: View {
    /// Пауза на каждой точке перед переходом к следующей.
    private let stepDuration: TimeInterval = 0.33
    /// Длительность crossfade градиент ↔ неактивная заливка.
    private let transitionDuration: TimeInterval = 0.5

    @State private var activeIndex = 0

    private let sizes: [CGFloat] = [19, 15, 10]

    private var bubbleShape: AIResponseBubbleShape {
        AIResponseBubbleShape(cornerRadius: AppShape.cornerRadius)
    }

    private var inactiveDotColor: Color {
        .white.opacity(0.1)
    }

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(0..<3, id: \.self) { dotIndex in
                dot(
                    at: dotIndex,
                    isActive: dotIndex == activeIndex
                )
            }
        }
        .padding(16)
        .frame(height: 51)
        .background(CardBlurBackground(shape: bubbleShape, opacity: 0.5))
        .clipShape(bubbleShape)
        .task { await runTypingAnimation() }
    }

    private func dot(at index: Int, isActive: Bool) -> some View {
        let size = sizes[index]

        return ZStack {
            Circle()
                .fill(inactiveDotColor)

            Circle()
                .fill(AppGradient.main)
                .opacity(isActive ? 1 : 0)
        }
        .frame(width: size, height: size)
    }

    @MainActor
    private func runTypingAnimation() async {
        while !Task.isCancelled {
            try? await Task.sleep(for: .seconds(stepDuration))

            withAnimation(.easeInOut(duration: transitionDuration)) {
                activeIndex = (activeIndex + 1) % 3
            }
        }
    }
}

private struct AIResponseBubbleShape: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        UnevenRoundedRectangle(
            topLeadingRadius: cornerRadius,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: cornerRadius,
            topTrailingRadius: cornerRadius,
            style: .continuous
        ).path(in: rect)
    }
}

#Preview {
    AIResponseIndicator()
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.background)
}
