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
    var diameter: CGFloat
    let content: AddendumContent

    @Environment(\.displayScale) private var displayScale

    private var cornerRadius: CGFloat { diameter * 16 / 100 }
    private var plusSize: CGFloat { diameter * 32 / 100 }
    private var closeSize: CGFloat { diameter * 24 / 100 }
    private var closeOffset: CGFloat { diameter * 6 / 100 }
    private var blurRadius: CGFloat { diameter * AppSurface.blurRadius / 100 }
    private var borderWidth: CGFloat {
        max(diameter * 1 / 100, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
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
                            .frame(width: diameter, height: diameter)
                            .clipShape(shape)
                    }
                    .overlay(alignment: .topTrailing) {
                        CloseButton(size: closeSize, style: .light, action: onClose)
                            .offset(x: closeOffset, y: -closeOffset)
                    }
            }
        }
        .frame(width: diameter, height: diameter)
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
                SpinnerView(diameter: plusSize)
            case .photo:
                EmptyView()
            }
        }
        .frame(width: diameter, height: diameter)
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
            extent: diameter,
            blurRadius: blurRadius,
            cardOpacity: 0.4,
            shape: shape
        )
    }

    private var plusIcon: some View {
        PlusIcon()
            .fill(Color.white)
            .frame(width: plusSize, height: plusSize)
    }

    private var gradientBorder: some View {
        shape
            .strokeBorder(AppGradient.main, lineWidth: borderWidth)
    }
}

#Preview {
    let size: CGFloat = 100

    VStack(spacing: size * 24 / 100) {
        Addendum(diameter: size, content: .add {})
        Addendum(diameter: size, content: .loading)
        Addendum(diameter: size,
            content: .photo(
                Image(systemName: "person.crop.rectangle.fill"),
                onClose: {}
            )
        )
    }
    .padding(24)
    .background(Color.background)
}
