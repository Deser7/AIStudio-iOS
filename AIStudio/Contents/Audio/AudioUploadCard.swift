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

/// Карточка загрузки аудио/видео (Figma «audio»).
struct AudioUploadCard: View {
    var size: CGFloat
    var state: AudioUploadState = .idle
    let onTap: () -> Void

    @Environment(\.displayScale) private var displayScale

    /// Figma ref width = 358, height = 279. Базовая единица — 16px.
    private var spacing: CGFloat { size * 16 / 358 }
    private var fontSize: CGFloat { spacing }
    private var subtitleFontSize: CGFloat { spacing * 14 / 16 }
    private var cardHeight: CGFloat { size * 279 / 358 }
    private var cornerRadius: CGFloat { spacing * 24 / 16 }
    private var iconSize: CGFloat { spacing * 48 / 16 }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }
    private var borderWidth: CGFloat {
        max(spacing / 16, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }
    /// Figma: icon 48 px, stroke 2 px.
    private var iconStrokeWidth: CGFloat {
        max(spacing * 2 / 16, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
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
        .frame(width: size, height: cardHeight)
        .overlay { errorBorder }
    }

    private var cardContent: some View {
        VStack(spacing: spacing) {
            if state == .loading {
                SpinnerView(size: iconSize)

                OnboardingTitleSection(
                    title: "Converting speech to text...",
                    subtitle: "",
                    style: .upload,
                    textSize: fontSize
                )
            } else {
                importIcon

                OnboardingTitleSection(
                    title: "Upload audio or video",
                    subtitle: supportedFormatsSubtitle,
                    style: .upload,
                    textSize: fontSize,
                    subtitleTextSize: subtitleFontSize
                )
            }
        }
        .padding(spacing)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { cardBackground }
        .clipShape(shape)
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
            .frame(width: iconSize, height: iconSize)
    }

    @ViewBuilder
    private var errorBorder: some View {
        if state == .error {
            shape
                .strokeBorder(Color.error, lineWidth: borderWidth)
        }
    }

    private var cardBackground: some View {
        BlurCardBackground(
            style: .compact,
            size: cardHeight,
            blurRadius: blurRadius,
            cardOpacity: AppSurface.CardOpacity.fill,
            shape: shape
        )
    }
}

#Preview {
    let size: CGFloat = 358

    VStack(spacing: size * 16 / 358) {
        AudioUploadCard(size: size, state: .idle, onTap: {})
        AudioUploadCard(size: size, state: .error, onTap: {})
        AudioUploadCard(size: size, state: .loading, onTap: {})
    }
    .padding(24)
    .background(Color.background)
}
