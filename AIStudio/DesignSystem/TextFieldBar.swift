//
//  TextFieldBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct TextFieldBar<Icon: View, Background: View, Border: View>: View {
    var placeholder: String
    var height: CGFloat
    @Binding var text: String
    @ViewBuilder var icon: () -> Icon
    @ViewBuilder var background: () -> Background
    @ViewBuilder var border: () -> Border

    private var spacing: CGFloat { height * 2 / 7 }
    private var cornerRadius: CGFloat { height * 3 / 7 }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    var body: some View {
        HStack(spacing: spacing) {
            icon()

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(Typography.font(style: .regular, size: spacing))
                    .foregroundColor(Color.white.opacity(0.5))
            )
            .typography(style: .regular, size: spacing)
            .foregroundColor(Color.white)
            .tint(Color.white)
        }
        .padding(spacing)
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .background { background() }
        .clipShape(shape)
        .overlay { border() }
        .appDisabledOpacity()
    }
}
