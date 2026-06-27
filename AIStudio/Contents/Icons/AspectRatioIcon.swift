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
    func icon(rowSize: CGFloat, isSelected: Bool) -> some View {
        AspectRatioIcon(ratio: self, rowSize: rowSize, isSelected: isSelected)
    }
}

/// Иконка соотношения сторон (Figma «Format» trailing).
struct AspectRatioIcon: View {
    let ratio: AspectRatio
    var rowSize: CGFloat
    var isSelected: Bool

    @Environment(\.displayScale) private var displayScale

    private var iconSize: CGSize {
        switch ratio {
        case .landscape16x9:
            return CGSize(width: rowSize * 32 / 44, height: rowSize * 19 / 44)
        case .portrait9x16:
            return CGSize(width: rowSize * 13 / 44, height: rowSize * 20 / 44)
        case .square1x1:
            let side = rowSize * 20 / 44
            return CGSize(width: side, height: side)
        }
    }
    private var cornerRadius: CGFloat { rowSize * 4 / 44 }
    private var strokeWidth: CGFloat {
        max(rowSize * 1 / 44, 1 / displayScale)
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
    let rowSize: CGFloat = 44

    HStack(spacing: 24) {
        AspectRatioIcon(ratio: .landscape16x9, rowSize: rowSize, isSelected: true)
        AspectRatioIcon(ratio: .portrait9x16, rowSize: rowSize, isSelected: false)
        AspectRatioIcon(ratio: .square1x1, rowSize: rowSize, isSelected: false)
    }
    .padding(24)
    .background(Color.background)
}
