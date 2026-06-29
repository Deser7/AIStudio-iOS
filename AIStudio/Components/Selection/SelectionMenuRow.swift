//
//  SelectionMenuRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct SelectionMenuRow<Trailing: View>: View {
    let title: String
    var isSelected: Bool
    let action: () -> Void
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Text(title)
                    .typography(style: .regular16)
                    .foregroundStyle(titleStyle)
                    .tracking(0)
                    .frame(maxWidth: .infinity, alignment: .leading)

                trailing()
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
        }
        .buttonStyle(.plain)
    }

    private var titleStyle: AnyShapeStyle {
        isSelected ? AnyShapeStyle(AppGradient.main) : AnyShapeStyle(.white)
    }
}

#Preview {
    VStack(spacing: 0) {
        SelectionMenuRow(title: "720p", isSelected: true, action: {}) {
            EmptyView()
        }
        SelectionMenuRow(title: "1080p", isSelected: false, action: {}) {
            EmptyView()
        }
    }
    .background(.card)
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    .padding(24)
    .background(Color.background)
}
