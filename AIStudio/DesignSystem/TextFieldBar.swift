//
//  TextFieldBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct TextFieldBar<Icon: View, Background: View, Border: View>: View {
    var placeholder: String
    var size: CGFloat
    @Binding var text: String
    @ViewBuilder var icon: () -> Icon
    @ViewBuilder var background: () -> Background
    @ViewBuilder var border: () -> Border

    private var padding: CGFloat { size * 2 / 7 }
    private var gap: CGFloat { size * 2 / 7 }
    private var fontSize: CGFloat { size * 2 / 7 }
    private var cornerRadius: CGFloat { size * 3 / 7 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        HStack(spacing: gap) {
            icon()

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(AppFont.font(weight: .regular, size: fontSize))
                    .foregroundColor(Color.accent.opacity(0.5))
            )
            .font(AppFont.font(weight: .regular, size: fontSize))
            .foregroundColor(Color.accent)
            .tint(Color.accent)
        }
        .padding(padding)
        .frame(maxWidth: .infinity)
        .frame(height: size)
        .background { background() }
        .clipShape(shape)
        .overlay { border() }
        .appDisabledOpacity()
    }
}
