//
//  TypographyStyle.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import CoreGraphics

enum TypographyStyle: CaseIterable {
    case regular12
    case regular14
    case regular16
    case regular20
    case medium12
    case medium14
    case medium16
    case medium20
    case semiBold14
    case semiBold16
    case semiBold20
    case semiBold24
    case bold16
    case bold28
    case bold34

    var fontSize: CGFloat {
        switch self {
        case .regular12, .medium12: 12
        case .regular14, .medium14, .semiBold14: 14
        case .regular16, .medium16, .semiBold16, .bold16: 16
        case .regular20, .medium20, .semiBold20: 20
        case .semiBold24: 24
        case .bold28: 28
        case .bold34: 34
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .regular14: 14
        case .regular16: 16
        case .semiBold20: 20
        case .bold34: 41
        default: fontSize
        }
    }

    var weightTitle: String {
        switch self {
        case .regular12, .regular14, .regular16, .regular20:
            "Regular"
        case .medium12, .medium14, .medium16, .medium20:
            "Medium"
        case .semiBold14, .semiBold16, .semiBold20, .semiBold24:
            "Semi Bold"
        case .bold16, .bold28, .bold34:
            "Bold"
        }
    }

    var postScriptName: String {
        switch self {
        case .regular12, .regular14, .regular16, .regular20:
            "Inter-Regular"
        case .medium12, .medium14, .medium16, .medium20:
            "Inter-Medium"
        case .semiBold14, .semiBold16, .semiBold20, .semiBold24:
            "Inter-SemiBold"
        case .bold16, .bold28, .bold34:
            "Inter-Bold"
        }
    }

    var boldVariant: TypographyStyle {
        switch fontSize {
        case 12: .bold16
        case 14: .bold16
        case 16: .bold16
        case 20: .bold28
        case 24: .bold28
        case 28: .bold28
        case 34: .bold34
        default: .bold16
        }
    }
}
