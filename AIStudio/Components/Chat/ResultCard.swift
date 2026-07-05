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

    var body: some View {
        Color.clear
            .aspectRatio(358 / 611, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .overlay {
                Image("Result")
                    .resizable()
                    .scaledToFill()
            }
            .clipShape(AppShape.card)
            .overlay(alignment: .topTrailing) {
                ReplaceButton(action: onReplace)
                    .padding(.top, 16)
                    .padding(.trailing, 16)
            }
            .overlay {
                Button(action: onPlay) {
                    PlayIcon()
                        .fill(.white)
                        .frame(width: 80, height: 80)
                }
                .buttonStyle(.plain)
            }
    }
}

#Preview {
    ResultCard(onReplace: {}, onPlay: {})
        .padding()
        .background(Color.background)
}
