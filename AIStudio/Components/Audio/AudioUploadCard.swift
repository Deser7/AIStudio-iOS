//
//  AudioUploadCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

enum AudioUploadState: Sendable {
    case idle
    case loading
    case error
}

struct AudioUploadCard: View {
    var state: AudioUploadState = .idle
    let onTap: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var borderWidth: CGFloat {
        max(1, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var iconStrokeWidth: CGFloat {
        max(2, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var supportedFormatsSubtitle: String {
        """
        MP3 • WAV • M4A • MP4 • MOV
        Max file size: 100 MB
        """
    }

    var body: some View {
        Group {
            if state == .loading {
                cardContent
            } else {
                Button(action: onTap) {
                    cardContent
                }
                .buttonStyle(.plain)
            }
        }
        .frame(width: 358, height: 279)
        .overlay { errorBorder }
    }

    private var cardContent: some View {
        VStack(spacing: 16) {
            if state == .loading {
                SpinnerView(size: 48)

                OnboardingTitleSection(
                    title: "Converting speech to text...",
                    subtitle: "",
                    style: .upload
                )
            } else {
                importIcon

                OnboardingTitleSection(
                    title: "Upload audio or video",
                    subtitle: supportedFormatsSubtitle,
                    style: .upload
                )
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(CardBlurBackground(opacity: 0.6))
    }

    private var importIcon: some View {
        ImportIcon()
            .stroke(
                AppGradient.main,
                style: StrokeStyle(
                    lineWidth: iconStrokeWidth,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .frame(width: 48, height: 48)
    }

    @ViewBuilder
    private var errorBorder: some View {
        if state == .error {
            AppShape.card
                .strokeBorder(.error, lineWidth: borderWidth)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        AudioUploadCard(state: .idle, onTap: {})
        AudioUploadCard(state: .error, onTap: {})
        AudioUploadCard(state: .loading, onTap: {})
    }
    .padding(24)
    .background(Color.background)
}
