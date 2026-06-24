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

    private var referenceSize: CGSize {
        switch self {
        case .generation, .done:
            CGSize(width: 24, height: 24)
        case .play:
            CGSize(width: 14, height: 16)
        case .pause:
            CGSize(width: 12, height: 16)
        }
    }

    func iconFrameSize(relativeTo buttonSize: CGFloat) -> CGSize {
        CGSize(
            width: scaled(referenceSize.width, buttonSize: buttonSize),
            height: scaled(referenceSize.height, buttonSize: buttonSize)
        )
    }

    private func scaled(_ value: CGFloat, buttonSize: CGFloat) -> CGFloat {
        buttonSize * value / GradientIconButton.defaultSize
    }
}

struct GradientIconButton: View {
    static let defaultSize: CGFloat = 40

    var size: CGFloat = GradientIconButton.defaultSize
    var icon: GradientIconButtonIcon = .generation
    let action: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var iconFrameSize: CGSize { icon.iconFrameSize(relativeTo: size) }
    private var strokeWidth: CGFloat {
        (min(iconFrameSize.width, iconFrameSize.height) * 0.1)
            .pixelAligned(to: displayScale)
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
        .appDisabledOpacity()
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
