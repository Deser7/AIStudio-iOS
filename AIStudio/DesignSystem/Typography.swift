//
//  Typography.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

enum Typography {
    enum Style: CaseIterable {
        case regular
        case medium
        case semiBold
        case bold

        var title: String {
            switch self {
            case .regular: "Regular"
            case .medium: "Medium"
            case .semiBold: "Semi Bold"
            case .bold: "Bold"
            }
        }

        fileprivate var postScriptName: String {
            switch self {
            case .regular: "Inter-Regular"
            case .medium: "Inter-Medium"
            case .semiBold: "Inter-SemiBold"
            case .bold: "Inter-Bold"
            }
        }

        fileprivate var systemWeight: Font.Weight {
            switch self {
            case .regular: .regular
            case .medium: .medium
            case .semiBold: .semibold
            case .bold: .bold
            }
        }
    }

    /// Figma type scale для preview.
    static let previewStyles: [(section: Style, sizes: [CGFloat], lineHeights: [CGFloat?])] = [
        (.semiBold, [14, 16, 20], [nil, 16, 20]),
        (.medium, [12, 16, 20], [nil, 16, nil]),
        (.regular, [14, 16, 20], [14, 16, nil]),
        (.bold, [28, 34], [nil, 41])
    ]

    static func font(style: Style, size: CGFloat) -> Font {
        Font(uiFont(style: style, size: size))
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
            attributes: textAttributes(style: .bold, size: size, color: uiColor)
        )
        mutable.append(
            NSAttributedString(
                string: " — \(suffix)",
                attributes: textAttributes(style: .regular, size: size, color: uiColor)
            )
        )
        return AttributedString(mutable)
    }

    fileprivate static func uiFont(style: Style, size: CGFloat) -> UIFont {
        UIFont(name: style.postScriptName, size: size)
            ?? .systemFont(ofSize: size, weight: uiWeight(for: style))
    }

    private static func uiWeight(for style: Style) -> UIFont.Weight {
        switch style {
        case .regular: .regular
        case .medium: .medium
        case .semiBold: .semibold
        case .bold: .bold
        }
    }

    private static func textAttributes(
        style: Style,
        size: CGFloat,
        color: UIColor
    ) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = size
        paragraphStyle.maximumLineHeight = size

        return [
            .font: uiFont(style: style, size: size),
            .foregroundColor: color,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]
    }
}

private struct TypographyModifier: ViewModifier {
    let style: Typography.Style
    let size: CGFloat
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Typography.font(style: style, size: size))
            .lineSpacing(lineHeight - size)
    }
}

extension View {
    /// Figma line height по умолчанию 100% (`lineHeight == size`).
    func typography(
        style: Typography.Style,
        size: CGFloat,
        lineHeight: CGFloat? = nil
    ) -> some View {
        let resolvedLineHeight = lineHeight ?? size
        return modifier(
            TypographyModifier(
                style: style,
                size: size,
                lineHeight: resolvedLineHeight
            )
        )
    }
}

#Preview("Typography") {
    ScrollView {
        VStack(alignment: .leading, spacing: 32) {
            ForEach(Typography.previewStyles, id: \.section) { group in
                VStack(alignment: .leading, spacing: 16) {
                    Text(group.section.title)
                        .typography(style: .semiBold, size: 20)

                    ForEach(Array(group.sizes.enumerated()), id: \.offset) { index, fontSize in
                        let lineHeight = group.lineHeights[index]

                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(Int(fontSize)) px")
                                .typography(style: .medium, size: 12)
                                .foregroundStyle(.secondary)

                            Text("The quick brown fox jumps over the lazy dog.")
                                .typography(
                                    style: group.section,
                                    size: fontSize,
                                    lineHeight: lineHeight ?? fontSize
                                )
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
        .padding(24)
    }
}
