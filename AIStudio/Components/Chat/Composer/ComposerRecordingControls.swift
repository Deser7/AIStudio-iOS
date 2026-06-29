//
//  ComposerRecordingControls.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 29.06.2026.
//

import SwiftUI

struct ComposerRecordingControls: View {
    var progress: CGFloat
    let onCancel: () -> Void
    let onConfirm: () -> Void

    private let buttonSize: CGFloat = 40

    var body: some View {
        HStack(spacing: 16) {
            CircularIconButton(size: buttonSize, icon: .cross, action: onCancel)

            AudioWaveform(progress: progress, inactiveOpacity: 0.2)
                .frame(maxWidth: .infinity)

            GradientIconButton(size: buttonSize, icon: .done, action: onConfirm)
        }
    }
}

#Preview {
    ComposerRecordingControls(progress: 0.45, onCancel: {}, onConfirm: {})
        .padding(24)
        .background(Color.background)
}
