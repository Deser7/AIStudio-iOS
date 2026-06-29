//
//  Addendum.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AddendumContent {
    case add(() -> Void)
    case loading
    case photo(Image, onClose: () -> Void)
}

struct Addendum: View {
    var size: CGFloat
    let content: AddendumContent

    @Environment(\.displayScale) private var displayScale

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
    }

    var body: some View {
        Group {
            switch content {
            case let .add(action):
                Button(action: action) {
                    tileContent
                }
                .buttonStyle(.plain)

            case .loading:
                tileContent

            case let .photo(image, onClose):
                tileContent
                    .overlay {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: size, height: size)
                            .clipShape(shape)
                    }
                    .overlay(alignment: .topTrailing) {
                        CloseButton(size: 24, style: .light, action: onClose)
                            .offset(x: 6, y: -6)
                    }
            }
        }
        .frame(width: size, height: size)
        .appDisabledOpacity()
    }

    @ViewBuilder
    private var tileContent: some View {
        ZStack {
            if needsBlurBackground {
                blurBackground
            }

            switch content {
            case .add:
                plusIcon
            case .loading:
                SpinnerView(size: 32)
            case .photo:
                EmptyView()
            }
        }
        .frame(width: size, height: size)
        .clipShape(shape)
        .overlay {
            if case .add = content {
                gradientBorder
                    .allowsHitTesting(false)
            }
        }
    }

    private var needsBlurBackground: Bool {
        if case .loading = content { return true }
        return false
    }

    private var blurBackground: some View {
        BlurCardBackground(
            style: .compact,
            extent: size,
            blurRadius: AppSurface.blurRadius,
            cardOpacity: 0.4,
            shape: shape
        )
    }

    private var plusIcon: some View {
        PlusIcon()
            .fill(.white)
            .frame(width: 32, height: 32)
    }

    private var gradientBorder: some View {
        shape
            .strokeBorder(
                AppGradient.main,
                lineWidth: max(
                    size * 1 / 100, 1 / displayScale
                )
                .pixelAligned(to: displayScale)
            )
    }
}

#Preview {
    let size: CGFloat = 100

    VStack(spacing: 24) {
        Addendum(size: size, content: .add {})
        Addendum(size: size, content: .loading)
        Addendum(size: size,
            content: .photo(
                Image(systemName: "person.crop.rectangle.fill"),
                onClose: {}
            )
        )
    }
    .padding(24)
    .background(Color.background)
}
