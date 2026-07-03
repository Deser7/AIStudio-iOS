//
//  CardBlurBackground.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import SwiftUI

struct CardBlurBackground<S: Shape>: View {
    var shape: S
    var fillColor: Color = .card
    var opacity: CGFloat

    init(shape: S, fillColor: Color = .card, opacity: CGFloat) {
        self.shape = shape
        self.fillColor = fillColor
        self.opacity = opacity
    }

    var body: some View {
        ZStack {
            BackdropBlurView()
            shape.fill(fillColor.opacity(opacity))
        }
        .allowsHitTesting(false)
    }
}

extension CardBlurBackground where S == RoundedRectangle {
    init(opacity: CGFloat, fillColor: Color = .card) {
        self.init(shape: AppShape.card, fillColor: fillColor, opacity: opacity)
    }
}

#Preview {
    AppGradient.main
        .frame(width: 342, height: 162)
        .background(CardBlurBackground(opacity: 0.6))
        .clipShape(AppShape.card)
        .padding(24)
        .background(Color.background)
}
