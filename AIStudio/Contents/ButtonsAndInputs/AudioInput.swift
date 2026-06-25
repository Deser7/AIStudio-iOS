//
//  AudioInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct AudioInput: View {
    var size: CGFloat
    var isPlaying: Bool
    var progress: CGFloat
    let onPlayPause: () -> Void

    private var spacing: CGFloat { size * 2 / 11 }
    private var sectionSpacing: CGFloat { size * 3 / 11 }
    private var buttonSize: CGFloat { size * 5 / 11 }
    private var blurRadius: CGFloat { size * AppSurface.blurRadius / 88 }

    private var clampedProgress: CGFloat {
        min(max(progress, 0), 1)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: sectionSpacing, style: .continuous)
    }

    var body: some View {
        HStack(spacing: spacing) {
            playbackButton

            AudioWaveform(
                progress: clampedProgress,
                height: buttonSize,
                inactiveOpacity: 0.2
            )
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, spacing)
        .padding(.vertical, sectionSpacing)
        .frame(maxWidth: .infinity)
        .frame(height: size)
        .background { background }
        .clipShape(shape)
        .appDisabledOpacity()
    }

    private var background: some View {
        BlurCardBackground(
            style: .bar,
            size: size,
            blurRadius: blurRadius,
            cardOpacity: AppSurface.CardOpacity.blurOverlay,
            shape: shape
        )
    }

    private var playbackButton: some View {
        GradientIconButton(
            size: buttonSize,
            icon: isPlaying ? .pause : .play,
            action: onPlayPause
        )
    }
}

#Preview {
    AudioInputPreview()
}

private struct AudioInputPreview: View {
    @State private var isPlaying = true

    var body: some View {
        let size: CGFloat = 88

        VStack(spacing: size * 11 / 50) {
            AudioInput(
                size: size,
                isPlaying: isPlaying,
                progress: 0.35,
                onPlayPause: { isPlaying.toggle() }
            )

            AudioInput(
                size: size * 1 / 2,
                isPlaying: false,
                progress: 0.65,
                onPlayPause: {}
            )

            AudioInput(
                size: size,
                isPlaying: true,
                progress: 0.35,
                onPlayPause: {}
            )
            .disabled(true)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
    }
}
