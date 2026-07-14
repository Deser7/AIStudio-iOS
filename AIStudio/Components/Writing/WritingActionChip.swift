//
//  WritingActionChip.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 13.07.2026.
//

import SwiftUI

struct WritingActionChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(key: title)
                .typography(style: .medium16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(CardBlurBackground(opacity: 0.5))
                .overlay {
                    AppShape.card
                        .strokeBorder(
                            isSelected ? AnyShapeStyle(AppGradient.main) : AnyShapeStyle(.clear),
                            lineWidth: 1
                        )
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 12) {
        WritingActionChip(title: "Improve", isSelected: false, action: {})
        WritingActionChip(title: "Fix grammar", isSelected: true, action: {})
    }
    .padding(24)
    .background(Color.background)
}
