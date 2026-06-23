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

    static func scaledBlurRadius(for size: CGFloat, referenceSize: CGFloat) -> CGFloat {
        size * blurRadius / referenceSize
    }
}
