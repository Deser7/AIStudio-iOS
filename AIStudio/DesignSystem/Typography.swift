//
//  Typography.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct TypographyStyle {
    let weight: AppFont.Weight
    let size: CGFloat
    let lineHeight: CGFloat?

    var font: Font {
        AppFont.font(weight: weight, size: size)
    }

    var label: String {
        "\(Int(size)) px"
    }
}

enum Typography {
    // MARK: - Bold

    static let bold34 = TypographyStyle(weight: .bold, size: 34, lineHeight: 41)
    static let bold28 = TypographyStyle(weight: .bold, size: 28, lineHeight: nil)

    // MARK: - Semi Bold

    static let semiBold20 = TypographyStyle(weight: .semiBold, size: 20, lineHeight: nil)
    static let semiBold16 = TypographyStyle(weight: .semiBold, size: 16, lineHeight: 16)
    static let semiBold14 = TypographyStyle(weight: .semiBold, size: 14, lineHeight: nil)

    // MARK: - Medium

    static let medium20 = TypographyStyle(weight: .medium, size: 20, lineHeight: nil)
    static let medium16 = TypographyStyle(weight: .medium, size: 16, lineHeight: 16)
    static let medium12 = TypographyStyle(weight: .medium, size: 12, lineHeight: nil)

    // MARK: - Regular

    static let regular20 = TypographyStyle(weight: .regular, size: 20, lineHeight: nil)
    static let regular16 = TypographyStyle(weight: .regular, size: 16, lineHeight: nil)
    static let regular14 = TypographyStyle(weight: .regular, size: 14, lineHeight: 14)

    /// Figma line height 100%.
    static func semiBold(size: CGFloat) -> TypographyStyle {
        TypographyStyle(weight: .semiBold, size: size, lineHeight: size)
    }

    static func medium(size: CGFloat) -> TypographyStyle {
        TypographyStyle(weight: .medium, size: size, lineHeight: size)
    }

    static func regular(size: CGFloat) -> TypographyStyle {
        TypographyStyle(weight: .regular, size: size, lineHeight: size)
    }

    static let allStyles: [(section: String, styles: [TypographyStyle])] = [
        ("Semi Bold", [semiBold16, semiBold20, semiBold14]),
        ("Medium", [medium12, medium16, medium20]),
        ("Regular", [regular20, regular16, regular14]),
        ("Bold", [bold28, bold34]),
    ]
}

private struct TypographyModifier: ViewModifier {
    let style: TypographyStyle

    func body(content: Content) -> some View {
        if let lineHeight = style.lineHeight {
            content
                .font(style.font)
                .lineSpacing(lineHeight - style.size)
        } else {
            content.font(style.font)
        }
    }
}

extension View {
    func typography(_ style: TypographyStyle) -> some View {
        modifier(TypographyModifier(style: style))
    }
}

#Preview("Typography") {
    ScrollView {
        VStack(alignment: .leading, spacing: 32) {
            ForEach(Typography.allStyles, id: \.section) { section in
                VStack(alignment: .leading, spacing: 16) {
                    Text(section.section)
                        .typography(Typography.semiBold20)

                    ForEach(Array(section.styles.enumerated()), id: \.offset) { _, style in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(style.label)
                                .typography(Typography.medium12)
                                .foregroundStyle(.secondary)

                            Text("The quick brown fox jumps over the lazy dog.")
                                .typography(style)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
        .padding(24)
    }
}
