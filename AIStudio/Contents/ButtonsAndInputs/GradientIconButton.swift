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
            CGSize(width: buttonSize * 0.6, height: buttonSize * 0.6)
        case .play:
            CGSize(width: buttonSize * 0.35, height: buttonSize * 0.4)
        case .pause:
            CGSize(width: buttonSize * 0.3, height: buttonSize * 0.4)
        }
    }
}

struct GradientIconButton: View {
    var size: CGFloat
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

#Preview {
    let size: CGFloat = 40

    HStack(spacing: size * 0.6) {
        GradientIconButton(size: size, icon: .generation) {}
        GradientIconButton(size: size, icon: .done) {}
        GradientIconButton(size: size, icon: .play) {}
        GradientIconButton(size: size, icon: .pause) {}
    }
    .padding(24)
    .background(Color.background)
}
