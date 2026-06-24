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
    
    var body: some View {
        ZStack {
            AppGradient.linear(preset)
                .frame(width: size, height: size)
                .clipShape(Circle())
            
            GenerateIcon()
                .fill(.accent)
                .frame(width: size * 0.6125, height: size * 0.6125)
        }
    }
}

#Preview {
    HStack(spacing: 16) {
        ForEach(AppGradient.Preset.allCases, id: \.self) { preset in
            VStack(spacing: 8) {
                Logo(size: 40, preset: preset)
                Logo(size: 32, preset: preset)
            }
        }
    }
}
