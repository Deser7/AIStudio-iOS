//
//  SectionChip.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct SectionChip: View {
    let title: String
    var isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(key: title)
                .typography(style: .regular14)
                .foregroundStyle(.white.opacity(isSelected ? 1 : 0.5))
                .tracking(0)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(height: 33)
                .background {
                    if isSelected {
                        AppGradient.main
                    } else {
                        CardBlurBackground(opacity: 0.6)
                    }
                }
                .clipShape(AppShape.card)
        }
        .buttonStyle(.plain)
        .fixedSize(horizontal: true, vertical: false)
    }
}

#Preview {
    HStack(spacing: 8) {
        SectionChip(title: "Popular", isSelected: true, action: {})
        SectionChip(title: "Funny", isSelected: false, action: {})
    }
    .padding(24)
    .background(.green)
}
