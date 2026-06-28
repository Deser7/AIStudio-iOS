//
//  DissolvingGradientBorder.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct DissolvingGradientBorder<S: InsettableShape>: View {
    let shape: S
    let containerWidth: CGFloat
    let lineWidth: CGFloat
    let cornerRadius: CGFloat

    var body: some View {
        ZStack {
            shape
                .strokeBorder(AppGradient.main, lineWidth: lineWidth)
                .mask(borderMask)
                .blur(radius: lineWidth * 0.75)
                .opacity(0.55)

            shape
                .strokeBorder(AppGradient.main, lineWidth: lineWidth)
                .mask(borderMask)
        }
    }

    /// Прозрачность в центре каждого скругления (слева/справа), ярче на прямых верхнем и нижнем краях.
    private var borderMask: LinearGradient {
        let cap = min(cornerRadius / max(containerWidth, 1), 0.5)
        let fadeEnd = cap
        let fadeStart = cap * 0.45
        let solidStart = min(cap * 1.15, 0.5)

        return LinearGradient(
            stops: [
                .init(color: .clear, location: 0),
                .init(color: .white.opacity(0.2), location: fadeStart),
                .init(color: .white.opacity(0.8), location: fadeEnd),
                .init(color: .white, location: solidStart),
                .init(color: .white, location: 1 - solidStart),
                .init(color: .white.opacity(0.8), location: 1 - fadeEnd),
                .init(color: .white.opacity(0.2), location: 1 - fadeStart),
                .init(color: .clear, location: 1)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

#Preview {
    let shape = RoundedRectangle(cornerRadius: 24, style: .continuous)

    return ZStack {
        shape.fill(Color.card.opacity(0.7))
        DissolvingGradientBorder(
            shape: shape,
            containerWidth: 358,
            lineWidth: 2,
            cornerRadius: 24
        )
    }
    .frame(width: 358, height: 56)
    .padding(24)
    .background(Color.background)
}
