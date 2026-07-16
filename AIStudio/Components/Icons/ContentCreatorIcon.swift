//
//  ContentCreatorIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct ContentCreatorIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.34375 * width, y: 0.15625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.40625 * width, y: 0.09375 * height),
            control1: CGPoint(x: 0.34375 * width, y: 0.12173 * height),
            control2: CGPoint(x: 0.37173 * width, y: 0.09375 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.78125 * width, y: 0.09375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.84375 * width, y: 0.15625 * height),
            control1: CGPoint(x: 0.81577 * width, y: 0.09375 * height),
            control2: CGPoint(x: 0.84375 * width, y: 0.12173 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.84375 * width, y: 0.71875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.78125 * width, y: 0.78125 * height),
            control1: CGPoint(x: 0.84375 * width, y: 0.75327 * height),
            control2: CGPoint(x: 0.81577 * width, y: 0.78125 * height)
        )

        strokePath.move(to: CGPoint(x: 0.15625 * width, y: 0.72355 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.28125 * width, y: 0.6923 * height),
            control1: CGPoint(x: 0.15625 * width, y: 0.72355 * height),
            control2: CGPoint(x: 0.21307 * width, y: 0.6923 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.75 * height),
            control1: CGPoint(x: 0.37216 * width, y: 0.6923 * height),
            control2: CGPoint(x: 0.38636 * width, y: 0.75 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.65625 * width, y: 0.71875 * height),
            control1: CGPoint(x: 0.59091 * width, y: 0.75 * height),
            control2: CGPoint(x: 0.65625 * width, y: 0.71875 * height)
        )

        strokePath.move(to: CGPoint(x: 0.15625 * width, y: 0.72355 * height))
        strokePath.addLine(to: CGPoint(x: 0.15625 * width, y: 0.34375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.21875 * width, y: 0.28125 * height),
            control1: CGPoint(x: 0.15625 * width, y: 0.30923 * height),
            control2: CGPoint(x: 0.18423 * width, y: 0.28125 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.59375 * width, y: 0.28125 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.65625 * width, y: 0.34375 * height),
            control1: CGPoint(x: 0.62827 * width, y: 0.28125 * height),
            control2: CGPoint(x: 0.65625 * width, y: 0.30923 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.65625 * width, y: 0.71875 * height))

        strokePath.move(to: CGPoint(x: 0.15625 * width, y: 0.72355 * height))
        strokePath.addLine(to: CGPoint(x: 0.15625 * width, y: 0.84375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.21875 * width, y: 0.90625 * height),
            control1: CGPoint(x: 0.15625 * width, y: 0.87827 * height),
            control2: CGPoint(x: 0.18423 * width, y: 0.90625 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.59375 * width, y: 0.90625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.65625 * width, y: 0.84375 * height),
            control1: CGPoint(x: 0.62827 * width, y: 0.90625 * height),
            control2: CGPoint(x: 0.65625 * width, y: 0.87827 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.65625 * width, y: 0.71875 * height))

        strokePath.move(to: CGPoint(x: 0.375 * width, y: 0.48438 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.45313 * width, y: 0.40625 * height),
            control1: CGPoint(x: 0.375 * width, y: 0.44123 * height),
            control2: CGPoint(x: 0.40998 * width, y: 0.40625 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.53125 * width, y: 0.48438 * height),
            control1: CGPoint(x: 0.49627 * width, y: 0.40625 * height),
            control2: CGPoint(x: 0.53125 * width, y: 0.44123 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.45313 * width, y: 0.5625 * height),
            control1: CGPoint(x: 0.53125 * width, y: 0.52752 * height),
            control2: CGPoint(x: 0.49627 * width, y: 0.5625 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.375 * width, y: 0.48438 * height),
            control1: CGPoint(x: 0.40998 * width, y: 0.5625 * height),
            control2: CGPoint(x: 0.375 * width, y: 0.52752 * height)
        )
        strokePath.closeSubpath()

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
    ContentCreatorIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
