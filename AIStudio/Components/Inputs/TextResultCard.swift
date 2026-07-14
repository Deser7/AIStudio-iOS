//
//  TextResultCard.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 14.07.2026.
//

import SwiftUI

struct TextResultCard: View {
    let text: String
    var isWaiting = false
    var placeholder = "Your result will appear here..."

    var body: some View {
        Group {
            if isWaiting {
                AIResponseIndicator(showsBackground: false)
            } else if text.isEmpty {
                Text(key: placeholder)
                    .typography(style: .regular16)
                    .foregroundStyle(.white.opacity(0.3))
            } else {
                SelectableText(text, style: .regular16, color: .white)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 106, alignment: .topLeading)
        .padding(.top, 24)
        .padding([.horizontal, .bottom], 16)
        .frame(maxWidth: .infinity)
        .frame(height: 162, alignment: .top)
        .background(CardBlurBackground(opacity: 0.6))
        .animation(.easeInOut(duration: 0.2), value: isWaiting)
    }
}

#Preview("Empty") {
    TextResultCard(text: "")
        .padding(24)
        .background(Color.background)
}

#Preview("Waiting") {
    TextResultCard(text: "", isWaiting: true)
        .padding(24)
        .background(Color.background)
}

#Preview("Filled") {
    TextResultCard(text: "Here is your rewritten text.")
        .padding(24)
        .background(Color.background)
}
