//
//  BackdropBlurView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

struct BackdropBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
