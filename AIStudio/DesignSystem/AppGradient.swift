//
//  AppGradient.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AppGradient {
    static let main = linear(.main)
    static let blue = linear(.blue)
    static let green = linear(.green)
    static let pink = linear(.pink)
    static let purple = linear(.purple)
    static let background = linear(.background)

    static func linear(_ preset: AppGradientPreset) -> LinearGradient {
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

    HStack(spacing: 8) {
        ForEach(AppGradientPreset.allCases, id: \.self) { preset in
            AppGradient.linear(preset)
                .frame(width: iconSize, height: iconSize)
                .clipShape(Circle())
        }
    }
    .padding(24)
    .background(.card)
}
