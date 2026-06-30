//
//  StudioBackground.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 30.06.2026.
//

import SwiftUI

struct StudioBackground: View {
    var body: some View {
        GeometryReader { geo in
            let size = geo.size

            ZStack {
                Color.background

                Ellipse()
                    .fill(AppGradient.main)
                    .frame(
                        width: size.width * 1.58771,
                        height: size.height * 0.29195
                    )
                    .rotationEffect(.degrees(18.36))
                    .blur(radius: 100)
                    .opacity(0.5)
                    .position(x: size.width * 0.5, y: 0)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview() {
    StudioBackground()
}
