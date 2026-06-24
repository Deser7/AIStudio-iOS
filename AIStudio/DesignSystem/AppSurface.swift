//
//  AppSurface.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

enum AppSurface {
    /// Figma «Blur»: 182.21
    static let blurRadius: CGFloat = 182.21

    enum CardOpacity {
        /// Input, audio — card поверх backdrop blur
        static let blurOverlay: CGFloat = 0.7
        /// Search bar
        static let fill: CGFloat = 0.6
        /// Addendum, replace button, adding photo
        static let compact: CGFloat = 0.4
    }

    enum BlurFrame {
        static let barWidthMultiplier: CGFloat = 4
        static let paddingMultiplier: CGFloat = 2
    }

    enum DissolvingBorder {
        static let blurMultiplier: CGFloat = 0.75
        static let softOpacity: CGFloat = 0.55
        static let fadeStartMultiplier: CGFloat = 0.45
        static let solidStartMultiplier: CGFloat = 1.15
    }

    enum Interaction {
        static let disabledOpacity: CGFloat = 0.6
        /// Navigation bar subtitle — Figma: #FFFFFF @ 30%.
        static let subtitleOpacity: CGFloat = 0.3
    }

    static func scaledBlurRadius(for size: CGFloat, referenceSize: CGFloat) -> CGFloat {
        size * blurRadius / referenceSize
    }
}
