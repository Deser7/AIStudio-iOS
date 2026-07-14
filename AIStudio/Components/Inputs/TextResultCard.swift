//
//  TextResultCard.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 14.07.2026.
//

import SwiftUI

struct TextResultCard: View {
    let text: String
    var placeholder = "Your result will appear here..."

    var body: some View {
        Group {
            if text.isEmpty {
                Text(key: placeholder)
            } else {
                Text(verbatim: text)
            }
        }
        .typography(style: .regular16)
        .foregroundStyle(text.isEmpty ? .white.opacity(0.3) : .white)
        .frame(maxWidth: .infinity, minHeight: 106, alignment: .topLeading)
        .padding(.top, 24)
        .padding([.horizontal, .bottom], 16)
        .frame(maxWidth: .infinity)
        .frame(height: 162, alignment: .top)
        .background(CardBlurBackground(opacity: 0.6))
    }
}

#Preview("Empty") {
    TextResultCard(text: "")
        .padding(24)
        .background(Color.background)
}

#Preview("Filled") {
    TextResultCard(text: "Here is your rewritten text.")
        .padding(24)
        .background(Color.background)
}
