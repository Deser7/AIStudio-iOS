//
//  SettingsButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct SettingsButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            SettingsIcon()
                .stroke(
                    .white.opacity(0.3),
                    style: StrokeStyle(
                        lineWidth: 2.16,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: 28, height: 28)
                .frame(width: 40, height: 40)
                .background(CardBlurBackground(shape: Circle(), opacity: 0.4))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SettingsButton(action: {})
        .padding(24)
}
