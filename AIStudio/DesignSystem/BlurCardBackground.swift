//
//  BlurCardBackground.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct BlurCardBackground<S: Shape>: View {
    enum Style {
        case bar
        case compact
    }

    var style: Style
    var extent: CGFloat
    var blurRadius: CGFloat
    var cardOpacity: CGFloat
    var fillColor: Color = .card
    var shape: S

    private var blurMaxWidth: CGFloat? {
        style == .bar ? .infinity : nil
    }

    var body: some View {
        ZStack {
            BackdropBlurView()
                .frame(width: blurWidth, height: blurHeight)
                .frame(maxWidth: blurMaxWidth, maxHeight: .infinity)

            shape
                .fill(fillColor.opacity(cardOpacity))
        }
        .allowsHitTesting(false)
    }

    private var blurInset: CGFloat { blurRadius * 2 }

    private var blurHeight: CGFloat { extent + blurInset }

    private var blurWidth: CGFloat {
        style == .bar ? blurRadius * 4 : blurHeight
    }
}

#Preview("Bar") {
    let shape = RoundedRectangle(cornerRadius: 24, style: .continuous)

    return AppGradient.main
        .frame(width: 358, height: 56)
        .background {
            BlurCardBackground(
                style: .bar,
                extent: 56,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.7,
                shape: shape
            )
        }
        .clipShape(shape)
        .padding(24)
        .background(Color.background)
}

#Preview("Compact") {
    let shape = RoundedRectangle(cornerRadius: 24, style: .continuous)

    return AppGradient.main
        .frame(width: 342, height: 162)
        .background {
            BlurCardBackground(
                style: .compact,
                extent: 162,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.6,
                shape: shape
            )
        }
        .clipShape(shape)
        .padding(24)
        .background(Color.background)
}
