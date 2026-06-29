//
//  PlayIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct PlayIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        path.move(to: CGPoint(x: 0.96429 * width, y: 0.44148 * height))
        path.addCurve(
            to: CGPoint(x: 0.96429 * width, y: 0.54973 * height),
            control1: CGPoint(x: 1.01191 * width, y: 0.46553 * height),
            control2: CGPoint(x: 1.01191 * width, y: 0.52568 * height)
        )
        path.addLine(to: CGPoint(x: 0.10714 * width, y: 0.98274 * height))
        path.addCurve(
            to: CGPoint(x: 0, y: 0.92862 * height),
            control1: CGPoint(x: 0.05952 * width, y: 1.0068 * height),
            control2: CGPoint(x: 0, y: 0.97673 * height)
        )
        path.addLine(to: CGPoint(x: 0, y: 0.06259 * height))
        path.addCurve(
            to: CGPoint(x: 0.10714 * width, y: 0.00847 * height),
            control1: CGPoint(x: 0, y: 0.01448 * height),
            control2: CGPoint(x: 0.05952 * width, y: -0.01559 * height)
        )
        path.addLine(to: CGPoint(x: 0.96429 * width, y: 0.44148 * height))
        path.closeSubpath()

        return path
    }
}

#Preview {
    PlayIcon()
        .fill(.black)
        .frame(width: 48, height: 48)
}
