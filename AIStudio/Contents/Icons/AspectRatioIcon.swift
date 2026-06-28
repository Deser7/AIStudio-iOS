//
//  AspectRatioIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

enum AspectRatio: CaseIterable, Hashable, Sendable {
    case landscape16x9
    case portrait9x16
    case square1x1

    var title: String {
        switch self {
        case .landscape16x9: "16:9"
        case .portrait9x16: "9:16"
        case .square1x1: "1:1"
        }
    }

    @ViewBuilder
    func icon(rowHeight: CGFloat, isSelected: Bool) -> some View {
        AspectRatioIcon(ratio: self, rowHeight: rowHeight, isSelected: isSelected)
    }
}

/// Иконка соотношения сторон (Figma «Format» trailing).
struct AspectRatioIcon: View {
    let ratio: AspectRatio
    var rowHeight: CGFloat
    var isSelected: Bool

    @Environment(\.displayScale) private var displayScale

    private var iconSize: CGSize {
        switch ratio {
        case .landscape16x9:
            return CGSize(width: rowHeight * 32 / 44, height: rowHeight * 19 / 44)
        case .portrait9x16:
            return CGSize(width: rowHeight * 13 / 44, height: rowHeight * 20 / 44)
        case .square1x1:
            let side = rowHeight * 20 / 44
            return CGSize(width: side, height: side)
        }
    }
    private var cornerRadius: CGFloat { rowHeight * 4 / 44 }
    private var strokeWidth: CGFloat {
        max(rowHeight * 1 / 44, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        shape
            .stroke(strokeStyle, lineWidth: strokeWidth)
            .frame(width: iconSize.width, height: iconSize.height)
    }

    private var strokeStyle: AnyShapeStyle {
        isSelected ? AnyShapeStyle(AppGradient.main) : AnyShapeStyle(Color.white)
    }
}

#Preview {
    let rowHeight: CGFloat = 44

    HStack(spacing: 24) {
        AspectRatioIcon(ratio: .landscape16x9, rowHeight: rowHeight, isSelected: true)
        AspectRatioIcon(ratio: .portrait9x16, rowHeight: rowHeight, isSelected: false)
        AspectRatioIcon(ratio: .square1x1, rowHeight: rowHeight, isSelected: false)
    }
    .padding(24)
    .background(Color.background)
}
