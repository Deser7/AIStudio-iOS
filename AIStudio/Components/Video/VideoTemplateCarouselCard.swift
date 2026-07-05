//
//  VideoTemplateCarouselCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct VideoTemplateCarouselCard: View {
    private static let cornerRadius: CGFloat = 16
    private static let aspectRatio: CGFloat = 331 / 311

    var body: some View {
        Color.clear
            .aspectRatio(Self.aspectRatio, contentMode: .fit)
            .overlay {
                Image("Card")
                    .resizable()
                    .scaledToFill()
            }
            .clipShape(
                RoundedRectangle(cornerRadius: Self.cornerRadius, style: .continuous)
            )
    }
}

#Preview {
    VideoTemplateCarouselCard()
        .frame(width: 331)
        .padding(24)
        .background(Color.background)
}
