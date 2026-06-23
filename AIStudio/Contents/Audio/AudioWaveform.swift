//
//  AudioWaveform.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct AudioWaveform: View {
    var progress: CGFloat
    var height: CGFloat
    var inactiveOpacity: CGFloat = 0.2
    var dividerOpacity: CGFloat = 0.15
    var dividerWidth: CGFloat = 1
    var segmentCount: Int = 4

    private var clampedProgress: CGFloat {
        min(max(progress, 0), 1)
    }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let playedWidth = width * clampedProgress
            let unplayedWidth = width - playedWidth

            ZStack(alignment: .leading) {
                if clampedProgress < 1 {
                    EqualizerIcon()
                        .fill(Color.accent.opacity(inactiveOpacity))
                        .frame(width: width, height: height)
                        .mask(alignment: .trailing) {
                            Rectangle()
                                .frame(width: unplayedWidth)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                }

                if clampedProgress > 0 {
                    AppGradient.main
                        .frame(width: width, height: height)
                        .mask {
                            EqualizerIcon()
                                .frame(width: width, height: height)
                        }
                        .frame(width: playedWidth, height: height, alignment: .leading)
                        .clipped()
                }

                segmentDividers(width: width, height: height)
            }
            .frame(width: width, height: height, alignment: .leading)
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

#Preview {
    AudioWaveformPreview()
        .padding(24)
        .background(Color.background)
}

private struct AudioWaveformPreview: View {
    @State private var progress: CGFloat = 0.42

    var body: some View {
        VStack(spacing: 24) {
            AudioWaveform(progress: progress, height: 40)

            Slider(value: $progress, in: 0...1)
        }
    }
}
