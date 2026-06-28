//
//  SpinnerView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct SpinnerView: View {
    private enum Layout {
        static let segmentCount = 8
        static let revolutionDuration: TimeInterval = 0.85
        static let animationMinimumInterval: TimeInterval = 1 / 60
        static let opacities: [CGFloat] = [1, 0.6, 0.35, 0.22, 0.15, 0.1, 0.07, 0.05]
    }

    var diameter: CGFloat

    var body: some View {
        TimelineView(.animation(minimumInterval: Layout.animationMinimumInterval)) { timeline in
            SpinnerIcon()
                .fill(AppGradient.main)
                .frame(width: diameter, height: diameter)
                .mask {
                    opacityMask
                        .frame(width: diameter, height: diameter)
                        .rotationEffect(.degrees(maskRotation(for: timeline.date)))
                }
        }
    }

    private func maskRotation(for date: Date) -> Double {
        let elapsed = date.timeIntervalSinceReferenceDate
        let progress = elapsed
            .truncatingRemainder(dividingBy: Layout.revolutionDuration)
            / Layout.revolutionDuration
        return progress * 360
    }

    /// Маска неподвижна относительно экрана, иконка стоит на месте — «бегущая» прозрачность.
    private var opacityMask: some View {
        AngularGradient(
            gradient: Gradient(
                stops: (0 ..< Layout.segmentCount).map { index in
                    let step = 1 / CGFloat(Layout.segmentCount)
                    return Gradient.Stop(
                        color: .white.opacity(Layout.opacities[index]),
                        location: CGFloat(index) * step
                    )
                } + [
                    Gradient.Stop(color: .white.opacity(Layout.opacities[0]), location: 1)
                ]
            ),
            center: .center
        )
    }
}

#Preview {
    SpinnerView(diameter: 32)
        .padding(24)
        .background(Color.background)
}
