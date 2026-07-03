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
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 24) {
                optionIcon
                    .frame(width: 32, height: 32)

                OnboardingTitleSection(
                    title: option.title,
                    subtitle: option.subtitle,
                    style: .sourceOption
                )
            }
            .padding(.leading, 24)
            .padding([.vertical, .trailing], 16)
            .frame(width: 358, height: 95, alignment: .leading)
            .background(CardBlurBackground(opacity: 0.6))
            .clipShape(AppShape.card)
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
}

#Preview {
    MediaSourceOptionRow(option: .files, action: {})
        .padding(24)
        .background(Color.background)
}
