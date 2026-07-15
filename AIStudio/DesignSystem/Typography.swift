//
//  Typography.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

enum Typography {
    /// Figma type scale для preview.
    static let previewGroups: [(weight: String, styles: [TypographyStyle])] = [
        ("Semi Bold", [.semiBold14, .semiBold16, .semiBold20]),
        ("Medium", [.medium12, .medium16, .medium20]),
        ("Regular", [.regular14, .regular16, .regular20]),
        ("Bold", [.bold28, .bold34])
    ]

    static func font(style: TypographyStyle) -> Font {
        Font(uiFont(style: style))
    }

    /// Жирное начало + regular продолжение (Figma bullet: Bold/16 + Regular/16).
    static func emphasizedText(
        _ emphasis: String,
        suffix: String,
        style: TypographyStyle = .regular16,
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
        style: TypographyStyle = .regular16,
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
        style: TypographyStyle,
        color: Color
    ) -> NSAttributedString {
        NSAttributedString(
            string: string,
            attributes: textAttributes(style: style, color: UIColor(color))
        )
    }

    static func uiFont(style: TypographyStyle) -> UIFont {
        UIFont(name: style.postScriptName, size: style.fontSize)
            ?? .systemFont(ofSize: style.fontSize, weight: uiWeight(for: style))
    }

    private static func uiWeight(for style: TypographyStyle) -> UIFont.Weight {
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
        style: TypographyStyle,
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
    let style: TypographyStyle
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Typography.font(style: style))
            .lineSpacing(lineHeight - style.fontSize)
    }
}

extension View {
    func typography(
        style: TypographyStyle,
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
