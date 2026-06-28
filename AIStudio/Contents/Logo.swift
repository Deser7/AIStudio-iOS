//
//  Logo.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct Logo: View {
    var diameter: CGFloat
    var preset = AppGradient.Preset.main
    var iconColor: Color = .white

    private var iconSize: CGFloat { diameter * 49 / 80 }

    var body: some View {
        ZStack {
            AppGradient.linear(preset)
                .frame(width: diameter, height: diameter)
                .clipShape(Circle())

            GenerateIcon()
                .fill(iconColor)
                .frame(width: iconSize, height: iconSize)
        }
    }
}

#Preview {
    let size: CGFloat = 40

    HStack(spacing: size * 2 / 5) {
        ForEach(AppGradient.Preset.allCases, id: \.self) { preset in
            VStack(spacing: size * 1 / 5) {
                Logo(diameter: size, preset: preset)
                Logo(diameter: size * 4 / 5, preset: preset)
            }
        }
    }
    .padding(24)
    .background(Color.background)
}
