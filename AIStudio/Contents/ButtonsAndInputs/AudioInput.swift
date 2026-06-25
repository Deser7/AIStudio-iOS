//
//  AudioInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct AudioInput: View {
    static let defaultSize: CGFloat = 88

    var size: CGFloat = AudioInput.defaultSize
    var isPlaying: Bool
    var progress: CGFloat
    let onPlayPause: () -> Void

    private var horizontalPadding: CGFloat { size * 16 / 88 }
    private var verticalPadding: CGFloat { size * 24 / 88 }
    private var gap: CGFloat { size * 16 / 88 }
    private var cornerRadius: CGFloat { size * 24 / 88 }
    private var buttonSize: CGFloat { size * 40 / 88 }
    private var waveformHeight: CGFloat { size * 40 / 88 }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }

    private var clampedProgress: CGFloat {
        min(max(progress, 0), 1)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        HStack(spacing: gap) {
            playbackButton

            AudioWaveform(
                progress: clampedProgress,
                height: waveformHeight,
                inactiveOpacity: 0.2
            )
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
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

// MARK: - Previews

#Preview {
    AudioInputPreview()
}

private struct AudioInputPreview: View {
    @State private var isPlaying = true

    var body: some View {
        let size = AudioInput.defaultSize

        VStack(spacing: size * 0.22) {
            AudioInput(
                size: size,
                isPlaying: isPlaying,
                progress: 0.35,
                onPlayPause: { isPlaying.toggle() }
            )

            AudioInput(
                size: size * 0.5,
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
