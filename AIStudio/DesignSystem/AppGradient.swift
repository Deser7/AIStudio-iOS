//
//  AppGradient.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AppGradient {
    enum Preset: CaseIterable {
        case main
        case blue
        case green
        case pink
        case purple

        var colors: (Color, Color) {
            switch self {
            case .main: (.aiBlue, .aiPink)
            case .blue: (.logoBlueOne, .logoBlueTwo)
            case .green: (.logoGreenOne, .logoGreenTwo)
            case .pink: (.logoPinkOne, .logoPinkTwo)
            case .purple: (.logoPurpleOne, .logoPurpleTwo)
            }
        }
    }

    /// Figma «main»: #98C6F7 → #EB5B92, горизонтально.
    static let main = linear(.main)

    static let blue = linear(.blue)
    static let green = linear(.green)
    static let pink = linear(.pink)
    static let purple = linear(.purple)

    static func linear(_ preset: Preset) -> LinearGradient {
        let colors = preset.colors
        return linear(from: colors.0, to: colors.1)
    }

    static func linear(
        from start: Color,
        to end: Color,
        startPoint: UnitPoint = .leading,
        endPoint: UnitPoint = .trailing
    ) -> LinearGradient {
        LinearGradient(
            colors: [start, end],
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
}

#Preview {
    let iconSize: CGFloat = 56

    HStack(spacing: iconSize * 3 / 10) {
        ForEach(AppGradient.Preset.allCases, id: \.self) { preset in
            AppGradient.linear(preset)
                .frame(width: iconSize, height: iconSize)
                .clipShape(Circle())
        }
    }
    .padding(24)
    .background(Color.background)
}
