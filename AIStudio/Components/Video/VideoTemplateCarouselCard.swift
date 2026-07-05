//
//  VideoTemplateCarouselCard.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct VideoTemplateCarouselCard: View {
    var body: some View {
        Color.clear
            .aspectRatio(331 / 311, contentMode: .fit)
            .overlay {
                Image("Card")
                    .resizable()
                    .scaledToFill()
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}

#Preview {
    VideoTemplateCarouselCard()
        .frame(width: 331)
        .padding(24)
        .background(Color.background)
}
