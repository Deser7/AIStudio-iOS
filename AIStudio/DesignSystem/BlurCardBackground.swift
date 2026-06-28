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
    var fillColor: Color = Color.card
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

    private var blurWidth: CGFloat {
        switch style {
        case .bar:
            blurRadius * 4
        case .compact:
            extent + blurRadius * 2
        }
    }

    private var blurHeight: CGFloat {
        extent + blurRadius * 2
    }
}
