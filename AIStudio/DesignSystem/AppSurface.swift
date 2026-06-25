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
        /// Addendum, replace button, adding photo, toast notification — Figma: #1F191F @ 40%.
        static let compact: CGFloat = 0.4
        /// AI response typing bubble — Figma: #1F191F @ 50%.
        static let responseBubble: CGFloat = 0.5
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
        /// Typing indicator inactive dot — Figma: accent @ 10%.
        static let typingDotInactiveOpacity: CGFloat = 0.1
        /// Notification error subtitle — Figma: accent @ 50%.
        static let notificationSubtitleOpacity: CGFloat = 0.5
    }
}
