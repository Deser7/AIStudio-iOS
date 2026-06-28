//
//  ResultCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct ResultCard: View {
    let onReplace: () -> Void
    let onPlay: () -> Void

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    var body: some View {
        ZStack {
            Image("Result")
                .resizable()
                .scaledToFill()
                .frame(width: 358, height: 611)
                .clipped()
        }
        .frame(width: 358, height: 611)
        .clipShape(shape)
        .overlay(alignment: .topTrailing) {
            ReplaceButton(action: onReplace)
                .padding(.top, 16)
                .padding(.trailing, 16)
        }
    }
}

#Preview {
    ResultCard(onReplace: {}, onPlay: {})
}
