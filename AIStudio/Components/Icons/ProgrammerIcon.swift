//
//  ProgrammerIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct ProgrammerIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.78125 * width, y: 0.4349 * height))
        strokePath.addLine(to: CGPoint(x: 0.90625 * width, y: 0.36198 * height))
        strokePath.addLine(to: CGPoint(x: 0.5 * width, y: 0.125 * height))
        strokePath.addLine(to: CGPoint(x: 0.09375 * width, y: 0.36198 * height))
        strokePath.addLine(to: CGPoint(x: 0.34375 * width, y: 0.50781 * height))

        strokePath.move(to: CGPoint(x: 0.78125 * width, y: 0.4349 * height))
        strokePath.addLine(to: CGPoint(x: 0.5 * width, y: 0.59896 * height))
        strokePath.addLine(to: CGPoint(x: 0.34375 * width, y: 0.50781 * height))

        strokePath.move(to: CGPoint(x: 0.78125 * width, y: 0.4349 * height))
        strokePath.addLine(to: CGPoint(x: 0.78125 * width, y: 0.68394 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.71831 * width, y: 0.79651 * height),
            control1: CGPoint(x: 0.78224 * width, y: 0.72748 * height),
            control2: CGPoint(x: 0.76149 * width, y: 0.7624 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.28169 * width, y: 0.79651 * height),
            control1: CGPoint(x: 0.58342 * width, y: 0.90307 * height),
            control2: CGPoint(x: 0.41662 * width, y: 0.90065 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.21875 * width, y: 0.68394 * height),
            control1: CGPoint(x: 0.23871 * width, y: 0.76334 * height),
            control2: CGPoint(x: 0.21776 * width, y: 0.72748 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.21875 * width, y: 0.4375 * height))

        strokePath.move(to: CGPoint(x: 0.34375 * width, y: 0.50781 * height))
        strokePath.addLine(to: CGPoint(x: 0.5 * width, y: 0.36198 * height))

        strokePath.move(to: CGPoint(x: 0.34375 * width, y: 0.50781 * height))
        strokePath.addLine(to: CGPoint(x: 0.34375 * width, y: 0.6875 * height))

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
    ProgrammerIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
