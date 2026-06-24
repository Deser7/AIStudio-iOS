//
//  AIResponseIndicator.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

/// Индикатор «AI печатает» — пузырь с тремя точками (Figma «AI's response»).
struct AIResponseIndicator: View {
    static let defaultSize: CGFloat = 51

    var size: CGFloat = AIResponseIndicator.defaultSize

    /// Пауза на каждой точке перед переходом к следующей.
    private let stepDuration: TimeInterval = 0.33
    /// Длительность crossfade градиент ↔ неактивная заливка.
    private let transitionDuration: TimeInterval = 0.5

    @State private var activeIndex = 0

    private var padding: CGFloat { size * 16 / 51 }
    private var dotSpacing: CGFloat { size * 4 / 51 }
    private var largeDotSize: CGFloat { size * 19 / 51 }
    private var mediumDotSize: CGFloat { size * 15 / 51 }
    private var smallDotSize: CGFloat { size * 10 / 51 }
    private var cornerRadius: CGFloat { size * 24 / 51 }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }

    private var inactiveDotColor: Color {
        Color.accent.opacity(AppSurface.Interaction.typingDotInactiveOpacity)
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
        .frame(height: size)
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
            size: size,
            blurRadius: blurRadius,
            cardOpacity: AppSurface.CardOpacity.responseBubble,
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

#Preview("AI's response") {
    AIResponseIndicator()
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.gray)
}

#Preview("AI's response — scaled") {
    GeometryReader { geo in
        AIResponseIndicator(size: geo.size.width * 0.2)
            .padding(.horizontal, geo.size.width * 0.064)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.background)
    }
}
