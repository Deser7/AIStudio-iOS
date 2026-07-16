//
//  LanguageTeacherIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct LanguageTeacherIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.65625 * width, y: 0.5625 * height))
        strokePath.addLine(to: CGPoint(x: 0.65625 * width, y: 0.53125 * height))

        strokePath.move(to: CGPoint(x: 0.65625 * width, y: 0.5625 * height))
        strokePath.addLine(to: CGPoint(x: 0.53125 * width, y: 0.5625 * height))

        strokePath.move(to: CGPoint(x: 0.78125 * width, y: 0.5625 * height))
        strokePath.addLine(to: CGPoint(x: 0.71875 * width, y: 0.5625 * height))
        strokePath.addLine(to: CGPoint(x: 0.65625 * width, y: 0.5625 * height))

        strokePath.move(to: CGPoint(x: 0.40625 * width, y: 0.59375 * height))
        strokePath.addLine(to: CGPoint(x: 0.40625 * width, y: 0.84375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.90625 * height),
            control1: CGPoint(x: 0.40625 * width, y: 0.87827 * height),
            control2: CGPoint(x: 0.43423 * width, y: 0.90625 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.84375 * width, y: 0.90625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.90625 * width, y: 0.84375 * height),
            control1: CGPoint(x: 0.87827 * width, y: 0.90625 * height),
            control2: CGPoint(x: 0.90625 * width, y: 0.87827 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.90625 * width, y: 0.46875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.84375 * width, y: 0.40625 * height),
            control1: CGPoint(x: 0.90625 * width, y: 0.43423 * height),
            control2: CGPoint(x: 0.87827 * width, y: 0.40625 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.59375 * width, y: 0.40625 * height))

        strokePath.move(to: CGPoint(x: 0.40625 * width, y: 0.59375 * height))
        strokePath.addLine(to: CGPoint(x: 0.40625 * width, y: 0.46875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.4375 * width, y: 0.41461 * height),
            control1: CGPoint(x: 0.40625 * width, y: 0.44562 * height),
            control2: CGPoint(x: 0.41882 * width, y: 0.42542 * height)
        )

        strokePath.move(to: CGPoint(x: 0.40625 * width, y: 0.59375 * height))
        strokePath.addLine(to: CGPoint(x: 0.15625 * width, y: 0.59375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.09375 * width, y: 0.53125 * height),
            control1: CGPoint(x: 0.12173 * width, y: 0.59375 * height),
            control2: CGPoint(x: 0.09375 * width, y: 0.56577 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.09375 * width, y: 0.15625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.15625 * width, y: 0.09375 * height),
            control1: CGPoint(x: 0.09375 * width, y: 0.12173 * height),
            control2: CGPoint(x: 0.12173 * width, y: 0.09375 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.53125 * width, y: 0.09375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.59375 * width, y: 0.15625 * height),
            control1: CGPoint(x: 0.56577 * width, y: 0.09375 * height),
            control2: CGPoint(x: 0.59375 * width, y: 0.12173 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.59375 * width, y: 0.40625 * height))

        strokePath.move(to: CGPoint(x: 0.59375 * width, y: 0.40625 * height))
        strokePath.addLine(to: CGPoint(x: 0.46875 * width, y: 0.40625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.4375 * width, y: 0.41461 * height),
            control1: CGPoint(x: 0.45737 * width, y: 0.40625 * height),
            control2: CGPoint(x: 0.44669 * width, y: 0.40929 * height)
        )

        strokePath.move(to: CGPoint(x: 0.71875 * width, y: 0.5625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.65625 * width, y: 0.7324 * height),
            control1: CGPoint(x: 0.71875 * width, y: 0.60135 * height),
            control2: CGPoint(x: 0.72913 * width, y: 0.67615 * height)
        )

        strokePath.move(to: CGPoint(x: 0.4375 * width, y: 0.41461 * height))
        strokePath.addLine(to: CGPoint(x: 0.4375 * width, y: 0.375 * height))

        strokePath.move(to: CGPoint(x: 0.65625 * width, y: 0.7324 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.5625 * width, y: 0.78125 * height),
            control1: CGPoint(x: 0.63144 * width, y: 0.75155 * height),
            control2: CGPoint(x: 0.6006 * width, y: 0.76855 * height)
        )

        strokePath.move(to: CGPoint(x: 0.65625 * width, y: 0.7324 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.61079 * width, y: 0.6875 * height),
            control1: CGPoint(x: 0.638 * width, y: 0.71831 * height),
            control2: CGPoint(x: 0.623 * width, y: 0.70306 * height)
        )

        strokePath.move(to: CGPoint(x: 0.65625 * width, y: 0.7324 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.75 * width, y: 0.78125 * height),
            control1: CGPoint(x: 0.68106 * width, y: 0.75155 * height),
            control2: CGPoint(x: 0.7119 * width, y: 0.76855 * height)
        )

        strokePath.move(to: CGPoint(x: 0.25 * width, y: 0.46875 * height))
        strokePath.addLine(to: CGPoint(x: 0.25 * width, y: 0.375 * height))

        strokePath.move(to: CGPoint(x: 0.25 * width, y: 0.375 * height))
        strokePath.addLine(to: CGPoint(x: 0.25 * width, y: 0.3125 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.34375 * width, y: 0.21875 * height),
            control1: CGPoint(x: 0.25 * width, y: 0.26072 * height),
            control2: CGPoint(x: 0.29197 * width, y: 0.21875 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.4375 * width, y: 0.3125 * height),
            control1: CGPoint(x: 0.39553 * width, y: 0.21875 * height),
            control2: CGPoint(x: 0.4375 * width, y: 0.26072 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.4375 * width, y: 0.375 * height))

        strokePath.move(to: CGPoint(x: 0.25 * width, y: 0.375 * height))
        strokePath.addLine(to: CGPoint(x: 0.4375 * width, y: 0.375 * height))

        path.addPath(
            strokePath.strokedPath(
                StrokeStyle(
                    lineWidth: 0.0625 * width,
                    lineCap: .round,
                    lineJoin: .round,
                    miterLimit: 4
                )
            )
        )

        return path
    }
}

#Preview {
    LanguageTeacherIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
