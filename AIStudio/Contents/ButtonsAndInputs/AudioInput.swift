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
        static let dividerOpacity: CGFloat = 0.15
        static let dividerWidthRatio: CGFloat = 1 / 88
        static let segmentCount: Int = 4
    }

    var size: CGFloat = AudioInput.defaultSize
    var isPlaying: Bool
    var progress: CGFloat
    let onPlayPause: () -> Void

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var horizontalPadding: CGFloat { size * Layout.horizontalPaddingRatio }
    private var verticalPadding: CGFloat { size * Layout.verticalPaddingRatio }
    private var gap: CGFloat { size * Layout.gapRatio }
    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var buttonSize: CGFloat { size * Layout.buttonSizeRatio }
    private var waveformHeight: CGFloat { size * Layout.waveformHeightRatio }
    private var blurRadius: CGFloat {
        AppSurface.scaledBlurRadius(for: size, referenceSize: Self.defaultSize)
    }
    private var dividerWidth: CGFloat {
        max(size * Layout.dividerWidthRatio, 1 / displayScale)
            .pixelAligned(to: displayScale)
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
                inactiveOpacity: Layout.inactiveWaveformOpacity,
                dividerOpacity: Layout.dividerOpacity,
                dividerWidth: dividerWidth,
                segmentCount: Layout.segmentCount
            )
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .frame(maxWidth: .infinity)
        .frame(height: size)
        .background { background }
        .clipShape(shape)
        .opacity(isEnabled ? 1 : 0.6)
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

// MARK: - Waveform

private struct AudioWaveform: View {
    var progress: CGFloat
    var height: CGFloat
    var inactiveOpacity: CGFloat
    var dividerOpacity: CGFloat
    var dividerWidth: CGFloat
    var segmentCount: Int

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width

            ZStack {
                EqualizerIcon()
                    .fill(Color.accent.opacity(inactiveOpacity))

                AppGradient.main
                    .frame(width: width, height: height)
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: width * progress)
                    }
                    .mask {
                        EqualizerIcon()
                    }

                segmentDividers(width: width, height: height)
            }
            .frame(width: width, height: height)
        }
        .frame(height: height)
    }

    private func segmentDividers(width: CGFloat, height: CGFloat) -> some View {
        ZStack {
            ForEach(1..<segmentCount, id: \.self) { index in
                Rectangle()
                    .fill(Color.accent.opacity(dividerOpacity))
                    .frame(width: dividerWidth, height: height)
                    .position(
                        x: width * CGFloat(index) / CGFloat(segmentCount),
                        y: height / 2
                    )
            }
        }
        .allowsHitTesting(false)
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
    @State private var progress: CGFloat = 0.35

    var body: some View {
        VStack(spacing: 24) {
            AudioInput(
                isPlaying: isPlaying,
                progress: progress,
                onPlayPause: { isPlaying.toggle() }
            )

            AudioInput(
                size: 110,
                isPlaying: false,
                progress: 0.65,
                onPlayPause: {}
            )

            Slider(value: $progress, in: 0...1)

            AudioInput(
                isPlaying: isPlaying,
                progress: progress,
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
