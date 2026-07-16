//
//  FitnessCoachIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct FitnessCoachIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.5625 * width, y: 0.40625 * height))
        strokePath.addLine(to: CGPoint(x: 0.4375 * width, y: 0.53125 * height))
        strokePath.addLine(to: CGPoint(x: 0.5625 * width, y: 0.53125 * height))
        strokePath.addLine(to: CGPoint(x: 0.4375 * width, y: 0.65625 * height))

        strokePath.move(to: CGPoint(x: 0.90625 * width, y: 0.37828 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.52901 * width, y: 0.83556 * height),
            control1: CGPoint(x: 0.90625 * width, y: 0.58984 * height),
            control2: CGPoint(x: 0.62195 * width, y: 0.77928 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.47099 * width, y: 0.83556 * height),
            control1: CGPoint(x: 0.51099 * width, y: 0.84648 * height),
            control2: CGPoint(x: 0.48901 * width, y: 0.84648 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.09375 * width, y: 0.37827 * height),
            control1: CGPoint(x: 0.37805 * width, y: 0.77928 * height),
            control2: CGPoint(x: 0.09375 * width, y: 0.58983 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.493 * width, y: 0.29408 * height),
            control1: CGPoint(x: 0.09375 * width, y: 0.10306 * height),
            control2: CGPoint(x: 0.41541 * width, y: 0.09408 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.507 * width, y: 0.29408 * height),
            control1: CGPoint(x: 0.49529 * width, y: 0.3 * height),
            control2: CGPoint(x: 0.50471 * width, y: 0.3 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.90625 * width, y: 0.37828 * height),
            control1: CGPoint(x: 0.58459 * width, y: 0.09408 * height),
            control2: CGPoint(x: 0.90625 * width, y: 0.10306 * height)
        )
        strokePath.closeSubpath()

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
    FitnessCoachIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
