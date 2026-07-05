//
//  TextFieldBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct TextFieldBar<Icon: View, Background: View, Border: View>: View {
    var placeholder: String
    var isEnabled = true
    @Binding var text: String
    @ViewBuilder var icon: () -> Icon
    @ViewBuilder var background: () -> Background
    @ViewBuilder var border: () -> Border

    var body: some View {
        HStack(spacing: 16) {
            icon()

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(Typography.font(style: .regular16))
                    .foregroundColor(.white.opacity(0.5))
            )
            .typography(style: .regular16)
            .foregroundColor(.white)
            .tint(.white)
            .disabled(!isEnabled)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background { background() }
        .clipShape(AppShape.card)
        .overlay { border() }
    }
}

#Preview {
    TextFieldBarPreview()
}

private struct TextFieldBarPreview: View {
    @State private var text = ""

    var body: some View {
        TextFieldBar(
            placeholder: "Ask anything...",
            text: $text,
            icon: {
                GenerateIcon()
                    .fill(.white, style: FillStyle(eoFill: true))
                    .frame(width: 24, height: 24)
            },
            background: { AppShape.card.fill(.card.opacity(0.6)) },
            border: { EmptyView() }
        )
        .padding(24)
        .background(Color.background)
    }
}
