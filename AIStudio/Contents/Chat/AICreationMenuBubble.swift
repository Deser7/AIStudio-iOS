//
//  AICreationMenuBubble.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct AICreationMenuBubble: View {
    let onSelect: (AICreationOption) -> Void

    private var bubbleShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("What do you want to create?")
                .typography(style: .semiBold16)
                .foregroundStyle(Color.white)
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
        .background { bubbleBackground }
        .clipShape(bubbleShape)
    }

    private var bubbleBackground: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .compact,
                extent: geo.size.height,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.5,
                shape: bubbleShape
            )
        }
    }
}

#Preview {
    AICreationMenuBubble { _ in }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
}
