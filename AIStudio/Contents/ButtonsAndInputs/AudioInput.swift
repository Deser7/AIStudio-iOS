//
//  AudioInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct AudioInput: View {
    static let defaultSize: CGFloat = 88

    private enum Layout {
        static let horizontalPaddingRatio: CGFloat = 16 / 88
        static let verticalPaddingRatio: CGFloat = 24 / 88
        static let gapRatio: CGFloat = 16 / 88
        static let cornerRadiusRatio: CGFloat = 24 / 88
        static let buttonSizeRatio: CGFloat = 40 / 88
        static let waveformHeightRatio: CGFloat = 40 / 88
        static let inactiveWaveformOpacity: CGFloat = 0.2
    }

    var size: CGFloat = AudioInput.defaultSize
    var isPlaying: Bool
    var progress: CGFloat
    let onPlayPause: () -> Void

    private var horizontalPadding: CGFloat { size * Layout.horizontalPaddingRatio }
    private var verticalPadding: CGFloat { size * Layout.verticalPaddingRatio }
    private var gap: CGFloat { size * Layout.gapRatio }
    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var buttonSize: CGFloat { size * Layout.buttonSizeRatio }
    private var waveformHeight: CGFloat { size * Layout.waveformHeightRatio }
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
                inactiveOpacity: Layout.inactiveWaveformOpacity
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

#Preview("input") {
    ZStack {
        Color.mint
            .ignoresSafeArea()

        AudioInputPreview()
            .padding(24)
    }
}

#Preview("input — scaled") {
    AudioInputScaledPreview()
}

private struct AudioInputPreview: View {
    @State private var isPlaying = true

    var body: some View {
        VStack(spacing: 24) {
            AudioInput(
                isPlaying: isPlaying,
                progress: 0.35,
                onPlayPause: { isPlaying.toggle() }
            )

            AudioInput(
                size: 110,
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
    }
}

private struct AudioInputScaledPreview: View {
    @State private var isPlaying = true

    var body: some View {
        GeometryReader { geo in
            let size = geo.size.width * 0.22

            AudioInput(
                size: size,
                isPlaying: isPlaying,
                progress: 0.42,
                onPlayPause: { isPlaying.toggle() }
            )
            .padding(.horizontal, geo.size.width * 0.064)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}
