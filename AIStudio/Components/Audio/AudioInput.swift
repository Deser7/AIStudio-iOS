//
//  AudioInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct AudioInput: View {
    var isPlaying: Bool
    var progress: CGFloat
    let onPlayPause: () -> Void

    private var clampedProgress: CGFloat {
        min(max(progress, 0), 1)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        HStack(spacing: 16) {
            playbackButton

            AudioWaveform(progress: clampedProgress)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .frame(height: 88)
        .background { background }
        .clipShape(shape)
        .appDisabledOpacity()
    }

    private var background: some View {
        BlurCardBackground(
            style: .bar,
            extent: 88,
            blurRadius: AppSurface.blurRadius,
            cardOpacity: 0.7,
            shape: shape
        )
    }

    private var playbackButton: some View {
        GradientIconButton(
            size: 40,
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

        VStack(spacing: 16) {
            AudioInput(
                isPlaying: isPlaying,
                progress: 0.35,
                onPlayPause: { isPlaying.toggle() }
            )

            AudioInput(
                isPlaying: false,
                progress: 0.65,
                onPlayPause: {}
            )

            AudioInput(
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
