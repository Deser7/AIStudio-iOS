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

    private var metrics: InputFieldMetrics {
        InputFieldMetrics(size: size)
    }

    var body: some View {
        HStack(spacing: metrics.gap) {
            icon()

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(AppFont.font(weight: .regular, size: metrics.fontSize))
                    .foregroundColor(Color.accent.opacity(InputFieldMetrics.placeholderOpacity))
            )
            .font(AppFont.font(weight: .regular, size: metrics.fontSize))
            .foregroundColor(Color.accent)
            .tint(Color.accent)
        }
        .padding(metrics.padding)
        .frame(maxWidth: .infinity)
        .frame(height: size)
        .background { background() }
        .clipShape(metrics.shape)
        .overlay { border() }
        .appDisabledOpacity()
    }
}
