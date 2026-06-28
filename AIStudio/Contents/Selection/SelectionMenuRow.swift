//
//  SelectionMenuRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Строка универсального меню выбора (Figma «Format» / «Quality» / «Language», height = 44).
struct SelectionMenuRow<Trailing: View>: View {
    let title: String
    var size: CGFloat
    var isSelected: Bool
    let action: () -> Void
    @ViewBuilder var trailing: () -> Trailing

    private var fontSize: CGFloat { size * 16 / 44 }
    private var horizontalPadding: CGFloat { size * 16 / 44 }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Text(title)
                    .typography(style: .regular, size: fontSize)
                    .foregroundStyle(titleStyle)
                    .tracking(0)
                    .frame(maxWidth: .infinity, alignment: .leading)

                trailing()
            }
            .padding(.horizontal, horizontalPadding)
            .frame(height: size)
        }
        .buttonStyle(.plain)
    }

    private var titleStyle: AnyShapeStyle {
        isSelected ? AnyShapeStyle(AppGradient.main) : AnyShapeStyle(Color.white)
    }
}

#Preview {
    let size: CGFloat = 44

    VStack(spacing: 0) {
        SelectionMenuRow(title: "720p", size: size, isSelected: true, action: {}) {
            EmptyView()
        }
        SelectionMenuRow(title: "1080p", size: size, isSelected: false, action: {}) {
            EmptyView()
        }
    }
    .background(Color.card)
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    .padding(24)
    .background(Color.background)
}
