//
//  AddingPhotoButton.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AddingPhotoButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            SettingsIcon()
                .stroke(
                    .white.opacity(0.5),
                    style: StrokeStyle(
                        lineWidth: 2.16,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: 24, height: 24)
                .padding(12)
                .frame(width: 40, height: 40)
                .background {
                    BlurCardBackground(
                        style: .compact,
                        extent: 40,
                        blurRadius: AppSurface.blurRadius,
                        cardOpacity: 0.4,
                        shape: Circle()
                    )
                }
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }
}

#Preview {
    AddingPhotoButton(action: {})
        .padding(24)
        .background(Color.background)
}
