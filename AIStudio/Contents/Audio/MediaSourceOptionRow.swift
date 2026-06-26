//
//  MediaSourceOptionRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

enum MediaSourceOption: CaseIterable, Identifiable, Sendable {
    case files
    case gallery

    var id: Self { self }

    var title: String {
        switch self {
        case .files: "Files"
        case .gallery: "Gallery"
        }
    }

    var subtitle: String {
        switch self {
        case .files: "Upload an audio or video file"
        case .gallery: "Select a video from your gallery"
        }
    }
}

struct MediaSourceOptionRow: View {
    let option: MediaSourceOption
    var size: CGFloat
    let action: () -> Void

    /// Figma ref width = 358, height = 95. Базовая единица — 16px.
    private var spacing: CGFloat { size * 16 / 358 }
    private var cardHeight: CGFloat { size * 95 / 358 }
    private var leadingPadding: CGFloat { spacing * 24 / 16 }
    private var cornerRadius: CGFloat { leadingPadding }
    private var iconSize: CGFloat { spacing * 32 / 16 }
    private var contentGap: CGFloat { leadingPadding }
    private var titleFontSize: CGFloat { spacing * 20 / 16 }
    private var subtitleFontSize: CGFloat { spacing }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: contentGap) {
                optionIcon
                    .frame(width: iconSize, height: iconSize)

                OnboardingTitleSection(
                    title: option.title,
                    subtitle: option.subtitle,
                    style: .sourceOption,
                    titleTextSize: titleFontSize,
                    subtitleTextSize: subtitleFontSize
                )
            }
            .padding(.leading, leadingPadding)
            .padding([.vertical, .trailing], spacing)
            .frame(width: size, height: cardHeight, alignment: .leading)
            .background { cardBackground }
            .clipShape(shape)
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var optionIcon: some View {
        switch option {
        case .files:
            DocumentIcon()
                .fill(AppGradient.main)
        case .gallery:
            GalleryIcon()
                .fill(AppGradient.main)
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

    MediaSourceOptionRow(option: .files, size: size, action: {})
        .padding(24)
        .background(Color.background)
}
