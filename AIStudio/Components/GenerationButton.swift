//
//  GenerationButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct GenerationButton: View {
    static let defaultSize: CGFloat = 40

    private enum Layout {
        static let iconScale: CGFloat = 0.6
        static let strokeScale: CGFloat = 0.1
    }

    var size: CGFloat = GenerationButton.defaultSize
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    private var iconSize: CGFloat {
        size * Layout.iconScale
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                LinearGradient(
                    colors: [.aiBlue, .aiPink],
                    startPoint: .leading,
                    endPoint: .trailing
                )

                SendIcon()
                    .stroke(
                        Color.accent,
                        style: StrokeStyle(
                            lineWidth: iconSize * Layout.strokeScale,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.6)
    }
}

#Preview("button/generation") {
    GenerationButton(size: 200) {}
}
