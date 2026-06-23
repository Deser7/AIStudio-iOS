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
        let mask = borderMask

        ZStack {
            shape
                .strokeBorder(AppGradient.main, lineWidth: lineWidth)
                .mask(mask)
                .blur(radius: lineWidth * AppSurface.DissolvingBorder.blurMultiplier)
                .opacity(AppSurface.DissolvingBorder.softOpacity)

            shape
                .strokeBorder(AppGradient.main, lineWidth: lineWidth)
                .mask(mask)
        }
    }

    /// Прозрачность в центре каждого скругления (слева/справа), ярче на прямых верхнем и нижнем краях.
    private var borderMask: LinearGradient {
        let cap = min(cornerRadius / max(containerWidth, 1), 0.5)
        let fadeEnd = cap
        let fadeStart = cap * AppSurface.DissolvingBorder.fadeStartMultiplier
        let solidStart = min(cap * AppSurface.DissolvingBorder.solidStartMultiplier, 0.5)

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
