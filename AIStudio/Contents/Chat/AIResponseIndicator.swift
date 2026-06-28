//
//  AIResponseIndicator.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

/// Индикатор «AI печатает» — пузырь с тремя точками (Figma «AI's response»).
struct AIResponseIndicator: View {
    var height: CGFloat

    /// Пауза на каждой точке перед переходом к следующей.
    private let stepDuration: TimeInterval = 0.33
    /// Длительность crossfade градиент ↔ неактивная заливка.
    private let transitionDuration: TimeInterval = 0.5

    @State private var activeIndex = 0

    private var padding: CGFloat { height * 16 / 51 }
    private var dotSpacing: CGFloat { height * 4 / 51 }
    private var largeDotSize: CGFloat { height * 19 / 51 }
    private var mediumDotSize: CGFloat { height * 15 / 51 }
    private var smallDotSize: CGFloat { height * 10 / 51 }
    private var cornerRadius: CGFloat { height * 24 / 51 }
    private var blurRadius: CGFloat { height * AppSurface.blurRadius / 51 }

    private var inactiveDotColor: Color {
        Color.white.opacity(0.1)
    }

    private var dotDiameters: [CGFloat] {
        [largeDotSize, mediumDotSize, smallDotSize]
    }

    private var bubbleShape: AIResponseBubbleShape {
        AIResponseBubbleShape(cornerRadius: cornerRadius)
    }

    var body: some View {
        HStack(alignment: .center, spacing: dotSpacing) {
            ForEach(0..<3, id: \.self) { dotIndex in
                dot(
                    at: dotIndex,
                    isActive: dotIndex == activeIndex
                )
            }
        }
        .padding(padding)
        .frame(height: height)
        .background { bubbleBackground }
        .clipShape(bubbleShape)
        .task { await runTypingAnimation() }
    }

    private func dot(at index: Int, isActive: Bool) -> some View {
        let diameter = dotDiameters[index]

        return ZStack {
            Circle()
                .fill(inactiveDotColor)

            Circle()
                .fill(AppGradient.main)
                .opacity(isActive ? 1 : 0)
        }
        .frame(width: diameter, height: diameter)
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

    private var bubbleBackground: some View {
        BlurCardBackground(
            style: .compact,
            extent: height,
            blurRadius: blurRadius,
            cardOpacity: 0.5,
            shape: bubbleShape
        )
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
    AIResponseIndicator(height: 51)
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.background)
}
