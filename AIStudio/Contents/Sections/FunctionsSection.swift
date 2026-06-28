//
//  FunctionsSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

/// Секция «Functions» с сеткой карточек (Figma «Functions»).
struct FunctionsSection: View {
    var width: CGFloat
    let onVideoTap: () -> Void
    let onWritingTap: () -> Void
    let onUnderstandTap: () -> Void

    /// Figma ref width = 358.
    private var columnGap: CGFloat { width * 8 / 358 }
    private var videoCardWidth: CGFloat { width * 172 / 358 }
    private var functionCardWidth: CGFloat { width * 178 / 358 }

    var body: some View {
        HStack(alignment: .top, spacing: columnGap) {
            AIVideoCard(width: videoCardWidth, action: onVideoTap)

            VStack(spacing: columnGap) {
                FunctionCard(
                    option: .fixWriting,
                    width: functionCardWidth,
                    action: onWritingTap
                )

                FunctionCard(
                    option: .understandFaster,
                    width: functionCardWidth,
                    action: onUnderstandTap
                )
            }
        }
        .frame(width: width, alignment: .leading)
    }
}

#Preview {
    let size: CGFloat = 358

    FunctionsSection(width: size,
        onVideoTap: {},
        onWritingTap: {},
        onUnderstandTap: {}
    )
    .padding(24)
    .background(Color.background)
}
