//
//  MediaSourcePicker.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Выбор источника медиа (Figma «Text settings»).
struct MediaSourcePicker: View {
    var width: CGFloat
    let onSelect: (MediaSourceOption) -> Void

    /// Figma ref width = 358. Базовая единица — 16px.
    private var spacing: CGFloat { width * 16 / 358 }
    private var rowSpacing: CGFloat { spacing * 12 / 16 }
    private var grabberWidth: CGFloat { spacing * 36 / 16 }
    private var grabberHeight: CGFloat { max(spacing * 5 / 16, 4) }

    var body: some View {
        VStack(spacing: rowSpacing) {
            Capsule()
                .fill(Color.white.opacity(0.3))
                .frame(width: grabberWidth, height: grabberHeight)

            VStack(spacing: rowSpacing) {
                ForEach(MediaSourceOption.allCases) { option in
                    MediaSourceOptionRow(option: option, width: width) {
                        onSelect(option)
                    }
                }
            }
        }
        .frame(width: width)
    }
}

#Preview {
    let size: CGFloat = 358
    let spacing = size * 16 / 358
    let sheetShape = RoundedRectangle(cornerRadius: spacing * 24 / 16, style: .continuous)

    ZStack(alignment: .bottom) {
        Color.background
            .ignoresSafeArea()

        MediaSourcePicker(width: size) { _ in }
            .padding(.top, spacing)
            .padding(.horizontal, spacing)
            .padding(.bottom, spacing * 24 / 16)
            .background(Color.card, in: sheetShape)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
    }
}
