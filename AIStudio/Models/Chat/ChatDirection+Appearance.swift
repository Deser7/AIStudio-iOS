//
//  ChatDirection+Appearance.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 17.07.2026.
//

import SwiftUI

extension ChatDirection {
    var logoIcon: LogoIcon {
        switch self {
        case .aiChat: .generate
        case .marketer: .marketer
        case .doctor: .doctor
        case .copywriter: .copywriter
        case .languageTeacher: .languageTeacher
        case .contentCreator: .contentCreator
        case .fitnessCoach: .fitnessCoach
        case .programmer: .programmer
        }
    }

    var gradientPreset: AppGradientPreset {
        switch self {
        case .aiChat: .main
        case .marketer, .copywriter: .blue
        case .doctor, .fitnessCoach: .pink
        case .languageTeacher, .programmer: .green
        case .contentCreator: .purple
        }
    }
}
