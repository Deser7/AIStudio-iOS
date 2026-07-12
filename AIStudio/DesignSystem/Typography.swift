//
//  Typography.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

enum Typography {
    enum Style: CaseIterable {
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

        fileprivate var postScriptName: String {
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

        fileprivate var boldVariant: Style {
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

    /// Figma type scale для preview.
    static let previewGroups: [(weight: String, styles: [Style])] = [
        ("Semi Bold", [.semiBold14, .semiBold16, .semiBold20]),
        ("Medium", [.medium12, .medium16, .medium20]),
        ("Regular", [.regular14, .regular16, .regular20]),
        ("Bold", [.bold28, .bold34])
    ]

    static func font(style: Style) -> Font {
        Font(uiFont(style: style))
    }

    /// Жирное начало + regular продолжение (Figma bullet: Bold/16 + Regular/16).
    static func emphasizedText(
        _ emphasis: String,
        suffix: String,
        style: Style = .regular16,
        color: Color
    ) -> AttributedString {
        AttributedString(
            emphasizedAttributedString(
                emphasis,
                suffix: suffix,
                style: style,
                color: color
            )
        )
    }

    static func emphasizedAttributedString(
        _ emphasis: String,
        suffix: String,
        style: Style = .regular16,
        color: Color
    ) -> NSAttributedString {
        let uiColor = UIColor(color)
        let mutable = NSMutableAttributedString(
            string: emphasis,
            attributes: textAttributes(style: style.boldVariant, color: uiColor)
        )
        mutable.append(
            NSAttributedString(
                string: " — \(suffix)",
                attributes: textAttributes(style: style, color: uiColor)
            )
        )
        return mutable
    }

    static func attributedString(
        _ string: String,
        style: Style,
        color: Color
    ) -> NSAttributedString {
        NSAttributedString(
            string: string,
            attributes: textAttributes(style: style, color: UIColor(color))
        )
    }

    static func uiFont(style: Style) -> UIFont {
        UIFont(name: style.postScriptName, size: style.fontSize)
            ?? .systemFont(ofSize: style.fontSize, weight: uiWeight(for: style))
    }

    private static func uiWeight(for style: Style) -> UIFont.Weight {
        switch style {
        case .regular12, .regular14, .regular16, .regular20:
            .regular
        case .medium12, .medium14, .medium16, .medium20:
            .medium
        case .semiBold14, .semiBold16, .semiBold20, .semiBold24:
            .semibold
        case .bold16, .bold28, .bold34:
            .bold
        }
    }

    private static func textAttributes(
        style: Style,
        color: UIColor
    ) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = style.lineHeight
        paragraphStyle.maximumLineHeight = style.lineHeight

        return [
            .font: uiFont(style: style),
            .foregroundColor: color,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]
    }
}

private struct TypographyModifier: ViewModifier {
    let style: Typography.Style
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Typography.font(style: style))
            .lineSpacing(lineHeight - style.fontSize)
    }
}

extension View {
    func typography(
        style: Typography.Style,
        lineHeight: CGFloat? = nil
    ) -> some View {
        modifier(
            TypographyModifier(
                style: style,
                lineHeight: lineHeight ?? style.lineHeight
            )
        )
    }
}

#Preview("Typography") {
    ScrollView {
        VStack(alignment: .leading, spacing: 32) {
            ForEach(Typography.previewGroups, id: \.weight) { group in
                VStack(alignment: .leading, spacing: 16) {
                    Text(group.weight)
                        .typography(style: .semiBold20)

                    ForEach(group.styles, id: \.self) { textStyle in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(Int(textStyle.fontSize)) px")
                                .typography(style: .medium12)
                                .foregroundStyle(.secondary)

                            Text("The quick brown fox jumps over the lazy dog.")
                                .typography(style: textStyle)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
        .padding(24)
    }
}
