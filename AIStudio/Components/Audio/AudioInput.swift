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

    var body: some View {
        HStack(spacing: 16) {
            GradientIconButton(
                size: 40,
                icon: isPlaying ? .pause : .play,
                action: onPlayPause
            )

            AudioWaveform(progress: clampedProgress)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(CardBlurBackground(opacity: 0.7))
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
        }
        .padding()
        .background(.green)
    }
}
