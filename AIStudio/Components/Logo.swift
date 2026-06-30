//
//  Logo.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct Logo: View {
    enum Icon {
        case generate
        case magic
    }

    var size: CGFloat
    var preset = AppGradient.Preset.main
    var icon: Icon = .generate
    var iconColor: Color = .white

    private var iconSize: CGFloat { size * 44 / 72 }

    var body: some View {
        ZStack {
            AppGradient.linear(preset)
                .frame(width: size, height: size)
                .clipShape(Circle())

            iconView
                .frame(width: iconSize, height: iconSize)
        }
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .generate:
            GenerateIcon()
                .fill(iconColor)
        case .magic:
            MagicIcon()
                .fill(iconColor)
        }
    }
}

#Preview {
    let size: CGFloat = 40

    HStack(spacing: 16) {
        ForEach(AppGradient.Preset.allCases, id: \.self) { preset in
            VStack(spacing: 8) {
                Logo(size: size, preset: preset, icon: .generate)
                Logo(size: size, preset: preset, icon: .magic)
            }
        }
    }
    .padding(24)
    .background(Color.background)
}
