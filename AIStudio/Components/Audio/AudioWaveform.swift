//
//  AudioWaveform.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct AudioWaveform: View {
    var progress: CGFloat

    private let height: CGFloat = 40

    private var clampedProgress: CGFloat { min(max(progress, 0), 1) }

    var body: some View {
        GeometryReader { geo in
            waveformContent(width: geo.size.width)
        }
        .frame(height: height)
    }

    @ViewBuilder
    private func waveformContent(width: CGFloat) -> some View {
        let unplayedWidth = self.unplayedWidth(in: width)

        ZStack(alignment: .leading) {
            if clampedProgress < 1 {
                EqualizerIcon()
                    .fill(.white.opacity(0.2))
                    .frame(width: width, height: height)
                    .mask(alignment: .trailing) {
                        Rectangle()
                            .frame(width: unplayedWidth)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
            }

            if clampedProgress > 0 {
                ZStack(alignment: .leading) {
                    ForEach(0..<5, id: \.self) { index in
                        playedSegment(
                            index: index,
                            totalWidth: width
                        )
                    }
                }
            }
        }
        .frame(width: width, height: height, alignment: .leading)
    }

    private func playedWidth(in totalWidth: CGFloat) -> CGFloat {
        totalWidth * clampedProgress
    }

    private func unplayedWidth(in totalWidth: CGFloat) -> CGFloat {
        totalWidth - playedWidth(in: totalWidth)
    }

    private func segmentStart(in totalWidth: CGFloat, at index: Int) -> CGFloat {
        totalWidth * EqualizerIcon.Layout.segmentStart(at: index)
    }

    private func segmentWidth(in totalWidth: CGFloat, at index: Int) -> CGFloat {
        totalWidth * (EqualizerIcon.Layout.segmentEnd(at: index) - EqualizerIcon.Layout.segmentStart(at: index))
    }

    private func segmentPlayedWidth(index: Int, totalWidth: CGFloat) -> CGFloat {
        let start = segmentStart(in: totalWidth, at: index)
        let width = segmentWidth(in: totalWidth, at: index)
        let playedWidth = totalWidth * clampedProgress
        return max(0, min(playedWidth - start, width))
    }

    @ViewBuilder
    private func playedSegment(index: Int, totalWidth: CGFloat) -> some View {
        let start = segmentStart(in: totalWidth, at: index)
        let width = segmentWidth(in: totalWidth, at: index)
        let played = segmentPlayedWidth(index: index, totalWidth: totalWidth)

        if played > 0 {
            AppGradient.main
                .frame(width: width, height: height)
                .mask(alignment: .leading) {
                    equalizerSegmentMask(
                        totalWidth: totalWidth,
                        segmentStart: start,
                        segmentWidth: width
                    )
                }
                .frame(width: played, height: height, alignment: .leading)
                .clipped()
                .frame(width: width, height: height, alignment: .leading)
                .offset(x: start)
        }
    }

    private func equalizerSegmentMask(
        totalWidth: CGFloat,
        segmentStart: CGFloat,
        segmentWidth: CGFloat
    ) -> some View {
        EqualizerIcon()
            .frame(width: totalWidth, height: height)
            .offset(x: -segmentStart)
            .frame(width: segmentWidth, height: height, alignment: .leading)
    }
}

#Preview {
    AudioWaveformPreview()
        .padding(24)
        .background(Color.background)
}

private struct AudioWaveformPreview: View {
    @State private var progress: CGFloat = 0.42

    var body: some View {
        VStack(spacing: 24) {
            AudioWaveform(progress: progress)

            Slider(value: $progress, in: 0...1)
        }
    }
}
