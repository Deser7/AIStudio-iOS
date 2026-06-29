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
    @Binding var text: String

    @Environment(\.displayScale) private var displayScale

    private var borderWidth: CGFloat {
        let borderRatio: CGFloat = switch style {
        case .main: 2
        case .search: 1
        }
        return CGFloat(borderRatio).pixelAligned(to: displayScale)
    }

    private var fieldShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        TextFieldBar(
            placeholder: placeholder,
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
                .fill(.white, style: FillStyle(eoFill: true))
                .frame(width: 24, height: 24)
        case .search:
            SearchIcon()
                .fill(.white)
                .frame(width: 24, height: 24)
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .main:
            BlurCardBackground(
                style: .bar,
                extent: 56,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.7,
                shape: fieldShape
            )
        case .search:
            fieldShape
                .fill(.card.opacity(0.6))
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
                    cornerRadius: 24
                )
            }
            .allowsHitTesting(false)
        case .search:
            fieldShape
                .strokeBorder(.white, lineWidth: borderWidth)
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
        VStack(spacing: 12) {
            AppInput(text: $mainText)
            AppInput(style: .search, text: $searchText)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.background)
    }
}
