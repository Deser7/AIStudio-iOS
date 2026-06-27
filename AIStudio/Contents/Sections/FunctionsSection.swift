//
//  FunctionsSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

/// Секция «Functions» с сеткой карточек (Figma «Functions»).
struct FunctionsSection: View {
    var size: CGFloat
    let onVideoTap: () -> Void
    let onWritingTap: () -> Void
    let onUnderstandTap: () -> Void

    /// Figma ref width = 358. Базовая единица — 16px.
    private var spacing: CGFloat { size * 16 / 358 }
    private var columnGap: CGFloat { size * 8 / 358 }
    private var headerIconSize: CGFloat { size * 12 / 358 }
    private var headerFontSize: CGFloat { size * 14 / 358 }
    private var videoCardWidth: CGFloat { size * 172 / 358 }
    private var functionCardWidth: CGFloat { size * 178 / 358 }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            sectionHeader

            HStack(alignment: .top, spacing: columnGap) {
                AIVideoCard(size: videoCardWidth, action: onVideoTap)

                VStack(spacing: columnGap) {
                    FunctionCard(
                        option: .fixWriting,
                        size: functionCardWidth,
                        action: onWritingTap
                    )

                    FunctionCard(
                        option: .understandFaster,
                        size: functionCardWidth,
                        action: onUnderstandTap
                    )
                }
            }
        }
        .frame(width: size, alignment: .leading)
    }

    private var sectionHeader: some View {
        HStack(spacing: spacing * 0.5) {
            GenerateIcon()
                .fill(AppGradient.main)
                .frame(width: headerIconSize, height: headerIconSize)

            Text("Functions")
                .typography(Typography.medium(size: headerFontSize))
                .foregroundStyle(AppGradient.main)
                .tracking(0)
        }
    }
}

#Preview {
    let size: CGFloat = 358

    FunctionsSection(
        size: size,
        onVideoTap: {},
        onWritingTap: {},
        onUnderstandTap: {}
    )
    .padding(24)
    .background(Color.background)
}
