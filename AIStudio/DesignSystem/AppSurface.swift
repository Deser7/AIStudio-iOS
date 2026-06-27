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

    enum BlurFrame {
        static let barWidthMultiplier: CGFloat = 4
        static let paddingMultiplier: CGFloat = 2
    }

    enum DissolvingBorder {
        static let blurMultiplier: CGFloat = 0.75
        static let fadeStartMultiplier: CGFloat = 0.45
        static let solidStartMultiplier: CGFloat = 1.15
    }

    enum FeatureCard {
        /// Figma letter spacing для 12 px.
        static let badgeLetterSpacing: CGFloat = 0.06
        /// Wave в ассете уже ~2/3 ширины — растягиваем до краёв карточки.
        static let waveHorizontalScale: CGFloat = 1.5
        /// Figma: gap между иконкой и текстом.
        static let contentSpacingRatio: CGFloat = 12 / 172
    }

    enum FunctionCard {
        /// Figma subtitle letter spacing для 12 px.
        static let subtitleLetterSpacing: CGFloat = -0.08
    }
}
