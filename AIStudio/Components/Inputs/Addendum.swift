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
    var content: AddendumContent

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
                            .clipShape(AppShape.card)
                    }
                    .overlay(alignment: .topTrailing) {
                        CloseButton(size: 24, style: .light, action: onClose)
                            .offset(x: 6, y: -6)
                    }
            }
        }
        .frame(width: size, height: size)
    }

    @ViewBuilder
    private var tileContent: some View {
        ZStack {
            if case .loading = content {
                CardBlurBackground(shape: shape, opacity: 0.4)
            }

            switch content {
            case .add:
                PlusIcon()
                    .fill(.white)
                    .frame(width: 32, height: 32)
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
                shape
                    .strokeBorder(
                        AppGradient.main,
                        lineWidth: 1
                    )
                    .allowsHitTesting(false)
            }
        }
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
    .background(.red)
}
