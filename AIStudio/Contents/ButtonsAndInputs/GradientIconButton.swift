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
    case play
    case pause

    func iconFrameSize(relativeTo buttonSize: CGFloat) -> CGSize {
        let base = GradientIconButton.defaultSize

        switch self {
        case .generation, .done:
            let side = buttonSize * 24 / base
            return CGSize(width: side, height: side)
        case .play:
            return CGSize(
                width: buttonSize * 14 / base,
                height: buttonSize * 16 / base
            )
        case .pause:
            return CGSize(
                width: buttonSize * 12 / base,
                height: buttonSize * 16 / base
            )
        }
    }
}

struct GradientIconButton: View {
    static let defaultSize: CGFloat = 40

    private enum Layout {
        static let strokeScale: CGFloat = 0.1
    }

    var size: CGFloat = GradientIconButton.defaultSize
    var icon: GradientIconButtonIcon = .generation
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var iconFrameSize: CGSize { icon.iconFrameSize(relativeTo: size) }
    private var strokeWidth: CGFloat {
        pixelAligned(min(iconFrameSize.width, iconFrameSize.height) * Layout.strokeScale)
    }

    private func pixelAligned(_ value: CGFloat) -> CGFloat {
        (value * displayScale).rounded() / displayScale
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                AppGradient.main

                iconView
                    .frame(width: iconFrameSize.width, height: iconFrameSize.height)
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
        case .play:
            PlayIcon()
                .fill(Color.accent)
        case .pause:
            PauseIcon()
                .fill(Color.accent)
        }
    }
}

#Preview("button/generation") {
    GradientIconButton(size: 100, icon: .generation) {}
    GradientIconButton(size: 100, icon: .done) {}
    GradientIconButton(size: 100, icon: .play) {}
    GradientIconButton(size: 100, icon: .pause) {}
}

#Preview("gradient icon buttons — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.1

        HStack(spacing: size * 0.6) {
            GradientIconButton(size: size, icon: .generation) {}
            GradientIconButton(size: size, icon: .done) {}
            GradientIconButton(size: size, icon: .play) {}
            GradientIconButton(size: size, icon: .pause) {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
