//
//  GradientIconButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct GradientIconButton: View {
    var size: CGFloat
    var icon: GradientIconButtonIcon = .generation
    let action: () -> Void

    private var iconFrameSize: CGSize { icon.iconFrameSize(relativeTo: size) }
    private var strokeWidth: CGFloat {
        min(iconFrameSize.width, iconFrameSize.height) * 1 / 10
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
    }

    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .generation:
            SendIcon()
                .stroke(
                    .white,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
        case .done:
            CheckIcon()
                .fill(.white)
        case .play:
            PlayIcon()
                .fill(.white)
        case .pause:
            PauseIcon()
                .fill(.white)
        }
    }
}

#Preview {
    let size: CGFloat = 40

    HStack(spacing: size * 24 / 40) {
        GradientIconButton(size: size, icon: .generation) {}
        GradientIconButton(size: size, icon: .done) {}
        GradientIconButton(size: size, icon: .play) {}
        GradientIconButton(size: size, icon: .pause) {}
    }
    .padding(24)
    .background(Color.background)
}
