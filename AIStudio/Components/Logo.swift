//
//  Logo.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct Logo: View {
    var size: CGFloat
    var preset: AppGradientPreset
    var icon: LogoIcon
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
        case .marketer:
            MarketerIcon()
                .fill(iconColor)
        case .doctor:
            DoctorIcon()
                .fill(iconColor)
        case .copywriter:
            CopywriterIcon()
                .fill(iconColor)
        case .languageTeacher:
            LanguageTeacherIcon()
                .fill(iconColor)
        case .contentCreator:
            ContentCreatorIcon()
                .fill(iconColor)
        case .fitnessCoach:
            FitnessCoachIcon()
                .fill(iconColor)
        case .designer:
            DesignerIcon()
                .fill(iconColor)
        case .programmer:
            ProgrammerIcon()
                .fill(iconColor)
        }
    }
}

#Preview {
    let size: CGFloat = 40
    let items: [(LogoIcon, AppGradientPreset)] = [
        (.marketer, .blue),
        (.doctor, .pink),
        (.copywriter, .blue),
        (.languageTeacher, .green),
        (.contentCreator, .purple),
        (.fitnessCoach, .pink),
        (.designer, .purple),
        (.programmer, .green),
    ]

    LazyVGrid(columns: [GridItem(.adaptive(minimum: size))], spacing: 16) {
        ForEach(Array(items.enumerated()), id: \.offset) { _, item in
            Logo(size: size, preset: item.1, icon: item.0)
        }
    }
    .padding(24)
    .background(Color.background)
}
