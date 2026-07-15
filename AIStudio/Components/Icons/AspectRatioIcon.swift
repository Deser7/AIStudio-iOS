//
//  AspectRatioIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct AspectRatioIcon: View {
    let ratio: AspectRatio
    var isSelected: Bool

    private var iconSize: CGSize {
        switch ratio {
        case .landscape16x9:
            return CGSize(width: 22, height: 14)
        case .portrait9x16:
            return CGSize(width: 13, height: 20)
        case .square1x1:
            return CGSize(width: 20, height: 20)
        }
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .stroke(strokeStyle, lineWidth: 1)
            .frame(width: iconSize.width, height: iconSize.height)
    }

    private var strokeStyle: AnyShapeStyle {
        isSelected ? AnyShapeStyle(AppGradient.main) : AnyShapeStyle(.white)
    }
}

#Preview {
    HStack(spacing: 24) {
        AspectRatioIcon(ratio: .landscape16x9, isSelected: true)
        AspectRatioIcon(ratio: .portrait9x16, isSelected: false)
        AspectRatioIcon(ratio: .square1x1, isSelected: false)
    }
    .padding(24)
    .background(Color.background)
}
