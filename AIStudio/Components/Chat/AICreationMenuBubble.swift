//
//  AICreationMenuBubble.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct AICreationMenuBubble: View {
    let onSelect: (AICreationOption) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("What do you want to create?")
                .typography(style: .semiBold16)
                .foregroundStyle(.white)
                .tracking(0)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 8) {
                ForEach(AICreationOption.allCases) { option in
                    AICreationOptionRow(option: option) {
                        onSelect(option)
                    }
                }
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .frame(width: 334, alignment: .leading)
        .background(CardBlurBackground(opacity: 0.5))
    }
}

#Preview {
    AICreationMenuBubble { _ in }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
}
