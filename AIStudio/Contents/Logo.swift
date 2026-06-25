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

    private var iconSize: CGFloat { size * 0.6125 }

    var body: some View {
        ZStack {
            AppGradient.linear(preset)
                .frame(width: size, height: size)
                .clipShape(Circle())

            GenerateIcon()
                .fill(.accent)
                .frame(width: iconSize, height: iconSize)
        }
    }
}

#Preview {
    let size: CGFloat = 40

    HStack(spacing: size * 0.4) {
        ForEach(AppGradient.Preset.allCases, id: \.self) { preset in
            VStack(spacing: size * 0.2) {
                Logo(size: size, preset: preset)
                Logo(size: size * 0.8, preset: preset)
            }
        }
    }
    .padding(24)
    .background(Color.background)
}
