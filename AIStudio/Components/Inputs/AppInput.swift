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
    var placeholder = "Ask anything..."
    @Binding var text: String

    var body: some View {
        TextFieldBar(
            placeholder: placeholder,
            text: $text,
            icon: {
                icon
                    .frame(width: 24, height: 24)
            },
            background: {
                CardBlurBackground(opacity: backgroundOpacity)
            },
            border: {
                border
            }
        )
    }

    @ViewBuilder
    private var icon: some View {
        switch style {
        case .main:
            GenerateIcon()
                .fill(.white)

        case .search:
            SearchIcon()
                .fill(.white)
        }
    }

    private var backgroundOpacity: CGFloat {
        style == .main ? 0.7 : 0.6
    }

    @ViewBuilder
    private var border: some View {
        if style == .main {
            GeometryReader { geo in
                DissolvingGradientBorder(
                    shape: AppShape.card,
                    containerWidth: geo.size.width,
                    lineWidth: 1,
                    cornerRadius: AppShape.cornerRadius
                )
            }
            .allowsHitTesting(false)
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
        .padding(24)
        .background(Color.background)
    }
}
