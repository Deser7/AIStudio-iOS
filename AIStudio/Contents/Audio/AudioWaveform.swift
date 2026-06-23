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

            ZStack {
                EqualizerIcon()
                    .fill(Color.accent.opacity(inactiveOpacity))

                AppGradient.main
                    .frame(width: width, height: height)
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: width * clampedProgress)
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

#Preview {
    AudioWaveform(progress: 0.42, height: 40)
        .padding(.horizontal, 24)
        .background(Color.background)
}
