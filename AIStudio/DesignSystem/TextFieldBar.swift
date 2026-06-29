//
//  TextFieldBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct TextFieldBar<Icon: View, Background: View, Border: View>: View {
    var placeholder: String
    @Binding var text: String
    @ViewBuilder var icon: () -> Icon
    @ViewBuilder var background: () -> Background
    @ViewBuilder var border: () -> Border

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        HStack(spacing: 16) {
            icon()

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(Typography.font(style: .regular16))
                    .foregroundColor(Color.white.opacity(0.5))
            )
            .typography(style: .regular16)
            .foregroundColor(Color.white)
            .tint(Color.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background { background() }
        .clipShape(shape)
        .overlay { border() }
        .appDisabledOpacity()
    }
}

#Preview {
    TextFieldBarPreview()
}

private struct TextFieldBarPreview: View {
    @State private var text = ""

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        TextFieldBar(
            placeholder: "Ask anything...",
            text: $text,
            icon: {
                GenerateIcon()
                    .fill(Color.white, style: FillStyle(eoFill: true))
                    .frame(width: 24, height: 24)
            },
            background: { shape.fill(Color.card.opacity(0.6)) },
            border: { EmptyView() }
        )
        .padding(24)
        .background(Color.background)
    }
}
