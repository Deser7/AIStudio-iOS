//
//  Logo.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct Logo: View {
    var size: CGFloat
    var preset = AppGradient.Preset.main
    var iconColor: Color = .accent

    private var iconSize: CGFloat { size * 49 / 80 }

    var body: some View {
        ZStack {
            AppGradient.linear(preset)
                .frame(width: size, height: size)
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
                Logo(size: size, preset: preset)
                Logo(size: size * 4 / 5, preset: preset)
            }
        }
    }
    .padding(24)
    .background(Color.background)
}
