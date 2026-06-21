//
//  GradientIconButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum GradientIconButtonIcon {
    case generation
    case done
}

struct GradientIconButton: View {
    static let defaultSize: CGFloat = 40

    private enum Layout {
        static let iconScale: CGFloat = 24 / 40
        static let strokeScale: CGFloat = 0.1
    }

    var size: CGFloat = GradientIconButton.defaultSize
    var icon: GradientIconButtonIcon = .generation
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var iconSize: CGFloat { size * Layout.iconScale }
    private var strokeWidth: CGFloat {
        pixelAligned(iconSize * Layout.strokeScale)
    }

    private func pixelAligned(_ value: CGFloat) -> CGFloat {
        (value * displayScale).rounded() / displayScale
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                LinearGradient(
                    colors: [.aiBlue, .aiPink],
                    startPoint: .leading,
                    endPoint: .trailing
                )

                iconView
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.6)
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .generation:
            SendIcon()
                .stroke(
                    Color.accent,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
        case .done:
            CheckIcon()
                .fill(Color.accent)
        }
    }
}

#Preview("button/generation") {
    GradientIconButton(size: 300, icon: .generation) {}
    GradientIconButton(size: 300, icon: .done) {}
}

#Preview("gradient icon buttons — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.1

        HStack(spacing: size * 0.6) {
            GradientIconButton(size: size, icon: .generation) {}
            GradientIconButton(size: size, icon: .done) {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
