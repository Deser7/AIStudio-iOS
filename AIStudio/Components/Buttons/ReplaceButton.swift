//
//  ReplaceButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ReplaceButton: View {
    var title: String = "Replace"
    let action: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var strokeWidth: CGFloat {
        CGFloat(2.16).pixelAligned(to: displayScale)
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                RefreshIcon()
                    .stroke(
                        .white,
                        style: StrokeStyle(
                            lineWidth: strokeWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: 24, height: 24)

                Text(title)
                    .typography(style: .regular14)
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 40)
            .background(CardBlurBackground(opacity: 0.4))
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReplaceButton(action: {})
        .padding(24)
//        .background(Color.background)
}
