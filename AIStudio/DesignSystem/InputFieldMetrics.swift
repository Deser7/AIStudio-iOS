//
//  InputFieldMetrics.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct InputFieldMetrics {
    static let referenceSize: CGFloat = 56

    static let paddingRatio: CGFloat = 16 / referenceSize
    static let gapRatio: CGFloat = 16 / referenceSize
    static let fontSizeRatio: CGFloat = 16 / referenceSize
    static let iconSizeRatio: CGFloat = 24 / referenceSize
    static let cornerRadiusRatio: CGFloat = 24 / referenceSize
    static let placeholderOpacity: CGFloat = 0.5

    let size: CGFloat

    var padding: CGFloat { size * Self.paddingRatio }
    var gap: CGFloat { size * Self.gapRatio }
    var fontSize: CGFloat { size * Self.fontSizeRatio }
    var iconSize: CGFloat { size * Self.iconSizeRatio }
    var cornerRadius: CGFloat { size * Self.cornerRadiusRatio }

    var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }
}
