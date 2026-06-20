//
//  AppFont.swift
//  AIStudio
//

import SwiftUI

enum AppFont {
    enum Weight: CaseIterable {
        case regular
        case medium
        case semiBold
        case bold

        var postScriptName: String {
            switch self {
            case .regular: "Inter-Regular"
            case .medium: "Inter-Medium"
            case .semiBold: "Inter-SemiBold"
            case .bold: "Inter-Bold"
            }
        }

        var title: String {
            switch self {
            case .regular: "Regular"
            case .medium: "Medium"
            case .semiBold: "Semi Bold"
            case .bold: "Bold"
            }
        }
    }

    static func font(weight: Weight, size: CGFloat) -> Font {
        .custom(weight.postScriptName, size: size)
    }
}
