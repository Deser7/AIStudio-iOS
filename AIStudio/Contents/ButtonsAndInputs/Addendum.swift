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
    static let defaultSize: CGFloat = 100

    private enum Layout {
        static let cornerRadiusRatio: CGFloat = 16 / 100
        static let plusSizeRatio: CGFloat = 32 / 100
        static let spinnerSizeRatio: CGFloat = 32 / 100
        static let closeSizeRatio: CGFloat = 24 / 100
        static let closeOffsetRatio: CGFloat = 6 / 100
        static let blurRatio: CGFloat = 182.21 / 100
        static let borderWidthRatio: CGFloat = 1 / 100
    }

    var size: CGFloat = Addendum.defaultSize
    let content: AddendumContent

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.displayScale) private var displayScale

    private var cornerRadius: CGFloat { size * Layout.cornerRadiusRatio }
    private var plusSize: CGFloat { size * Layout.plusSizeRatio }
    private var spinnerSize: CGFloat { size * Layout.spinnerSizeRatio }
    private var closeSize: CGFloat { size * Layout.closeSizeRatio }
    private var closeOffset: CGFloat { size * Layout.closeOffsetRatio }
    private var blurRadius: CGFloat { size * Layout.blurRatio }
    private var borderWidth: CGFloat {
        pixelAligned(max(size * Layout.borderWidthRatio, 1 / displayScale))
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var borderGradient: LinearGradient {
        LinearGradient(
            colors: [.aiBlue, .aiPink],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private func pixelAligned(_ value: CGFloat) -> CGFloat {
        (value * displayScale).rounded() / displayScale
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
                        CloseButton(size: closeSize, style: .light, action: onClose)
                            .offset(x: closeOffset, y: -closeOffset)
                    }
            }
        }
        .frame(width: size, height: size)
        .opacity(isEnabled ? 1 : 0.6)
    }

    @ViewBuilder
    private var tileContent: some View {
        ZStack {
            background

            switch content {
            case .add:
                plusIcon
            case .loading:
                SpinnerView(size: spinnerSize)
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

    private var background: some View {
        ZStack {
            BackdropBlurView()
                .frame(
                    width: size + blurRadius * 2,
                    height: size + blurRadius * 2
                )

            shape
                .fill(Color.card.opacity(0.4))
        }
    }

    private var plusIcon: some View {
        PlusIcon()
            .fill(Color.accent)
            .frame(width: plusSize, height: plusSize)
    }

    private var gradientBorder: some View {
        shape
            .strokeBorder(borderGradient, lineWidth: borderWidth)
    }
}

private struct BackdropBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview("Addendum") {
    VStack(spacing: 24) {
        Addendum(content: .add {})

        Addendum(content: .loading)

        Addendum(
            content: .photo(
                Image(systemName: "person.crop.rectangle.fill"),
                onClose: {}
            )
        )
    }
    .padding(24)
    .background(Color.cyan)
}

#Preview("Addendum — scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.25

        VStack(spacing: size * 0.24) {
            Addendum(size: size, content: .add {})
            Addendum(size: size, content: .loading)
            Addendum(
                size: size,
                content: .photo(
                    Image(systemName: "person.crop.rectangle.fill"),
                    onClose: {}
                )
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
