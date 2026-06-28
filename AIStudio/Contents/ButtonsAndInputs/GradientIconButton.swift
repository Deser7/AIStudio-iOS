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
        switch self {
        case .generation, .done:
            let iconSize = buttonSize * 24 / 40
            return CGSize(width: iconSize, height: iconSize)
        case .play:
            return CGSize(width: buttonSize * 14 / 40, height: buttonSize * 16 / 40)
        case .pause:
            return CGSize(width: buttonSize * 12 / 40, height: buttonSize * 16 / 40)
        }
    }
}

struct GradientIconButton: View {
    var diameter: CGFloat
    var icon: GradientIconButtonIcon = .generation
    let action: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var iconFrameSize: CGSize { icon.iconFrameSize(relativeTo: diameter) }
    private var strokeWidth: CGFloat {
        (min(iconFrameSize.width, iconFrameSize.height) * 1 / 10)
            .pixelAligned(to: displayScale)
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                AppGradient.main

                iconView
                    .frame(width: iconFrameSize.width, height: iconFrameSize.height)
            }
            .frame(width: diameter, height: diameter)
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
                    Color.white,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
        case .done:
            CheckIcon()
                .fill(Color.white)
        case .play:
            PlayIcon()
                .fill(Color.white)
        case .pause:
            PauseIcon()
                .fill(Color.white)
        }
    }
}

#Preview {
    let size: CGFloat = 40

    HStack(spacing: size * 24 / 40) {
        GradientIconButton(diameter: size, icon: .generation) {}
        GradientIconButton(diameter: size, icon: .done) {}
        GradientIconButton(diameter: size, icon: .play) {}
        GradientIconButton(diameter: size, icon: .pause) {}
    }
    .padding(24)
    .background(Color.background)
}
