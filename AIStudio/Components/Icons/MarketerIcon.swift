//
//  MarketerIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct MarketerIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.15625 * width, y: 0.84375 * height))
        strokePath.addLine(to: CGPoint(x: 0.15625 * width, y: 0.6875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.1875 * width, y: 0.65625 * height),
            control1: CGPoint(x: 0.15625 * width, y: 0.67024 * height),
            control2: CGPoint(x: 0.17024 * width, y: 0.65625 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.375 * width, y: 0.65625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.40625 * width, y: 0.625 * height),
            control1: CGPoint(x: 0.39226 * width, y: 0.65625 * height),
            control2: CGPoint(x: 0.40625 * width, y: 0.64226 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.40625 * width, y: 0.4375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.4375 * width, y: 0.40625 * height),
            control1: CGPoint(x: 0.40625 * width, y: 0.42024 * height),
            control2: CGPoint(x: 0.42024 * width, y: 0.40625 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.625 * width, y: 0.40625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.65625 * width, y: 0.375 * height),
            control1: CGPoint(x: 0.64226 * width, y: 0.40625 * height),
            control2: CGPoint(x: 0.65625 * width, y: 0.39226 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.65625 * width, y: 0.1875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.6875 * width, y: 0.15625 * height),
            control1: CGPoint(x: 0.65625 * width, y: 0.17024 * height),
            control2: CGPoint(x: 0.67024 * width, y: 0.15625 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.875 * width, y: 0.15625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.90625 * width, y: 0.1875 * height),
            control1: CGPoint(x: 0.89226 * width, y: 0.15625 * height),
            control2: CGPoint(x: 0.90625 * width, y: 0.17024 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.90625 * width, y: 0.84375 * height))

        strokePath.move(to: CGPoint(x: 0.09375 * width, y: 0.375 * height))
        strokePath.addLine(to: CGPoint(x: 0.3125 * width, y: 0.15625 * height))

        strokePath.move(to: CGPoint(x: 0.15625 * width, y: 0.15625 * height))
        strokePath.addLine(to: CGPoint(x: 0.3125 * width, y: 0.15625 * height))
        strokePath.addLine(to: CGPoint(x: 0.3125 * width, y: 0.3125 * height))

        path.addPath(
            strokePath.strokedPath(
                StrokeStyle(
                    lineWidth: 0.0625 * width,
                    lineCap: .round,
                    lineJoin: .round,
                    miterLimit: 1.78829
                )
            )
        )

        return path
    }
}

#Preview {
    MarketerIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
