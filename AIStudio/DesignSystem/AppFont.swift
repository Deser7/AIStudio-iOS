//
//  AppFont.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
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

    /// Жирное начало + regular продолжение (Figma bullet: Bold/16 + Regular/16).
    static func emphasizedText(
        _ emphasis: String,
        suffix: String,
        size: CGFloat,
        color: Color
    ) -> AttributedString {
        let uiColor = UIColor(color)
        let mutable = NSMutableAttributedString(
            string: emphasis,
            attributes: textAttributes(weight: .bold, size: size, color: uiColor)
        )
        mutable.append(
            NSAttributedString(
                string: " — \(suffix)",
                attributes: textAttributes(weight: .regular, size: size, color: uiColor)
            )
        )
        return AttributedString(mutable)
    }

    private static func uiFont(weight: Weight, size: CGFloat) -> UIFont {
        UIFont(name: weight.postScriptName, size: size)
            ?? .systemFont(ofSize: size, weight: weight == .bold ? .bold : .regular)
    }

    private static func textAttributes(
        weight: Weight,
        size: CGFloat,
        color: UIColor
    ) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = size
        paragraphStyle.maximumLineHeight = size

        return [
            .font: uiFont(weight: weight, size: size),
            .foregroundColor: color,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]
    }
}
