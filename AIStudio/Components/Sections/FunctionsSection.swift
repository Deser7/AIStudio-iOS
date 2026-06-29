//
//  FunctionsSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

/// Секция «Functions» с сеткой карточек (Figma «Functions»).
struct FunctionsSection: View {
    let onVideoTap: () -> Void
    let onWritingTap: () -> Void
    let onUnderstandTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            AIVideoCard(action: onVideoTap)

            VStack(spacing: 8) {
                FunctionCard(option: .fixWriting, action: onWritingTap)
                FunctionCard(option: .understandFaster, action: onUnderstandTap)
            }
        }
        .frame(width: 358, alignment: .leading)
    }
}

#Preview {
    FunctionsSection(
        onVideoTap: {},
        onWritingTap: {},
        onUnderstandTap: {}
    )
    .padding(24)
    .background(Color.background)
}
