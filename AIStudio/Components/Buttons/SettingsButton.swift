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
                .background {
                    ZStack {
                        BackdropBlurView(radius: AppSurface.blurRadius)
                        Circle()
                            .fill(.card.opacity(0.4))
                    }
                }
                .clipShape(Circle())
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }
}

#Preview {
    SettingsButton(action: {})
        .padding(24)
//        .background(Color.background)
}
