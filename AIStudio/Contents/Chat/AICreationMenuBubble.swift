//
//  AICreationMenuBubble.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Меню выбора сценария в пузыре AI (Figma «AI's response/Default»).
struct AICreationMenuBubble: View {
    var size: CGFloat
    let onSelect: (AICreationOption) -> Void

    /// Figma ref width = 334. Базовая единица — 16px.
    private var spacing: CGFloat { size * 16 / 334 }
    private var fontSize: CGFloat { spacing }
    private var subtitleFontSize: CGFloat { spacing * 14 / 16 }
    private var cornerRadius: CGFloat { spacing * 24 / 16 }
    private var rowHeight: CGFloat { size * 72 / 334 }
    private var rowSpacing: CGFloat { spacing * 8 / 16 }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }

    private var bubbleShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: cornerRadius) {
            Text("What do you want to create?")
                .typography(Typography.semiBold(size: fontSize))
                .foregroundStyle(Color.accent)
                .tracking(0)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: rowSpacing) {
                ForEach(AICreationOption.allCases) { option in
                    AICreationOptionRow(
                        option: option,
                        size: rowHeight,
                        titleFontSize: fontSize,
                        subtitleFontSize: subtitleFontSize
                    ) {
                        onSelect(option)
                    }
                }
            }
        }
        .padding(.top, cornerRadius)
        .padding(.horizontal, spacing)
        .padding(.bottom, spacing)
        .frame(width: size, alignment: .leading)
        .background { bubbleBackground }
        .clipShape(bubbleShape)
    }

    private var bubbleBackground: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .compact,
                size: geo.size.height,
                blurRadius: blurRadius,
                cardOpacity: AppSurface.CardOpacity.responseBubble,
                shape: bubbleShape
            )
        }
    }
}

#Preview {
    let size: CGFloat = 334

    AICreationMenuBubble(size: size) { _ in }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
}
