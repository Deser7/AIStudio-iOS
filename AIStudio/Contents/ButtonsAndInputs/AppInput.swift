//
//  AppInput.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AppInputStyle {
    case main
    case search
}

struct AppInput: View {
    var style: AppInputStyle = .main
    var placeholder: String = "Ask anything..."
    var height: CGFloat
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var iconSize: CGFloat { height * 3 / 7 }
    private var borderWidth: CGFloat {
        let borderRatio: CGFloat = switch style {
        case .main: 1 / 28
        case .search: 1 / 56
        }
        return max(height * borderRatio, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }
    private var blurRadius: CGFloat { height * AppSurface.blurRadius / 56 }

    private var fieldShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: iconSize, style: .continuous)
    }

    var body: some View {
        TextFieldBar(
            placeholder: placeholder,
            height: height,
            text: $text,
            icon: { iconView },
            background: { backgroundView },
            border: { borderView }
        )
    }

    @ViewBuilder
    private var iconView: some View {
        switch style {
        case .main:
            GenerateIcon()
                .fill(Color.white, style: FillStyle(eoFill: true))
                .frame(width: iconSize, height: iconSize)
        case .search:
            SearchIcon()
                .fill(Color.white)
                .frame(width: iconSize, height: iconSize)
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .main:
            BlurCardBackground(
                style: .bar,
                extent: height,
                blurRadius: blurRadius,
                cardOpacity: 0.7,
                shape: fieldShape
            )
        case .search:
            fieldShape
                .fill(Color.card.opacity(0.6))
        }
    }

    @ViewBuilder
    private var borderView: some View {
        switch style {
        case .main:
            GeometryReader { geo in
                DissolvingGradientBorder(
                    shape: fieldShape,
                    containerWidth: geo.size.width,
                    lineWidth: borderWidth,
                    cornerRadius: iconSize
                )
            }
            .allowsHitTesting(false)
        case .search:
            fieldShape
                .strokeBorder(Color.white, lineWidth: borderWidth)
        }
    }
}

#Preview {
    AppInputPreview()
}

private struct AppInputPreview: View {
    @State private var mainText = ""
    @State private var searchText = ""

    var body: some View {
        let size: CGFloat = 56

        VStack(spacing: size * 12 / 50) {
            AppInput(height: size, text: $mainText)
            AppInput(style: .search, height: size, text: $searchText)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
    }
}
