//
//  MediaSourceOptionRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

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
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, minHeight: 95, alignment: .leading)
            .background(CardBlurBackground(opacity: 0.6))
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
    VStack {
        MediaSourceOptionRow(option: .files, action: {})
        MediaSourceOptionRow(option: .gallery, action: {})
    }
    .padding()
    .background(.red)
}
