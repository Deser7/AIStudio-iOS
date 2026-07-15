//
//  AppGradientPreset.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AppGradientPreset: CaseIterable {
    case main
    case blue
    case green
    case pink
    case purple
    case background

    var colors: (Color, Color) {
        switch self {
        case .main: (.aiBlue, .aiPink)
        case .blue: (.logoBlueOne, .logoBlueTwo)
        case .green: (.logoGreenOne, .logoGreenTwo)
        case .pink: (.logoPinkOne, .logoPinkTwo)
        case .purple: (.logoPurpleOne, .logoPurpleTwo)
        case .background: (.background.opacity(0.9), .background)
        }
    }
}
