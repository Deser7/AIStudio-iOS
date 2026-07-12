//
//  ProButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ProButton: View {
    var title: String = "PRO"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(key: title)
                    .typography(style: .regular16)
                    .foregroundStyle(Color.background)
                    .lineLimit(1)

                Color.clear
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.white, in: Capsule())
            .fixedSize(horizontal: true, vertical: false)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 16) {
        ProButton(action: {})
//            .disabled(true)
    }
    .padding(24)
    .background(Color.background)
}
