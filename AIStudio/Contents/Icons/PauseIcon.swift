//
//  PauseIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct PauseIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        path.addRoundedRect(
            in: CGRect(
                x: 0,
                y: 0,
                width: 0.33333 * width,
                height: height
            ),
            cornerSize: CGSize(
                width: 0.16667 * width,
                height: 0.125 * height
            )
        )

        path.addRoundedRect(
            in: CGRect(
                x: 0.66667 * width,
                y: 0,
                width: 0.33333 * width,
                height: height
            ),
            cornerSize: CGSize(
                width: 0.16667 * width,
                height: 0.125 * height
            )
        )

        return path
    }
}

#Preview {
    PauseIcon()
        .fill(.black)
        .frame(width: 120, height: 160)
}
