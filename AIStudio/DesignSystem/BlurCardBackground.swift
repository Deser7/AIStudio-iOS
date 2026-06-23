//
//  BlurCardBackground.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct BlurCardBackground<S: Shape>: View {
    enum Style {
        /// Горизонтальный бар: input, audio.
        case bar
        /// Квадрат / круг: addendum, adding photo.
        case compact
    }

    var style: Style
    var size: CGFloat
    var blurRadius: CGFloat
    var cardOpacity: CGFloat
    var shape: S

    var body: some View {
        ZStack {
            BackdropBlurView()
                .frame(width: blurWidth, height: blurHeight)
                .frame(maxWidth: style == .bar ? .infinity : nil, maxHeight: .infinity)

            shape
                .fill(Color.card.opacity(cardOpacity))
        }
    }

    private var blurWidth: CGFloat {
        switch style {
        case .bar:
            blurRadius * AppSurface.BlurFrame.barWidthMultiplier
        case .compact:
            size + blurRadius * AppSurface.BlurFrame.paddingMultiplier
        }
    }

    private var blurHeight: CGFloat {
        size + blurRadius * AppSurface.BlurFrame.paddingMultiplier
    }
}
