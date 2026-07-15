//
//  GradientIconButtonIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import CoreGraphics

enum GradientIconButtonIcon {
    case generation
    case done
    case play
    case pause

    func iconFrameSize(relativeTo buttonSize: CGFloat) -> CGSize {
        switch self {
        case .generation, .done:
            let iconSize = buttonSize * 24 / 40
            return CGSize(width: iconSize, height: iconSize)
        case .play:
            return CGSize(width: buttonSize * 14 / 40, height: buttonSize * 16 / 40)
        case .pause:
            return CGSize(width: buttonSize * 12 / 40, height: buttonSize * 16 / 40)
        }
    }
}
