//
//  BackdropBlurView.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 03.07.2026.
//

import SwiftUI

struct BackdropBlurView: View {
    private struct BackdropView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIVisualEffectView {
            let view = UIVisualEffectView()
            let blur = UIBlurEffect()
            view.effect = blur
            return view
        }
        
        func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
    }
    
    @ViewBuilder
    var body: some View {
        BackdropView().blur(radius: 4)
    }
}

#Preview() {
    ZStack {
        Text("Test Test Test Test Test")
            .font(.largeTitle)
        
        BackdropBlurView()
            .frame(width: 100, height: 100)
    }
}
