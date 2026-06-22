//
//  SearchIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 22.06.2026.
//

import SwiftUI

struct SearchIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath2 = Path()
        strokePath2.move(to: CGPoint(x: 0.47917 * width, y: 0.875 * height))
        strokePath2.addCurve(
            to: CGPoint(x: 0.875 * width, y: 0.47917 * height),
            control1: CGPoint(x: 0.69778 * width, y: 0.875 * height),
            control2: CGPoint(x: 0.875 * width, y: 0.69778 * height)
        )
        strokePath2.addCurve(
            to: CGPoint(x: 0.47917 * width, y: 0.08333 * height),
            control1: CGPoint(x: 0.875 * width, y: 0.26055 * height),
            control2: CGPoint(x: 0.69778 * width, y: 0.08333 * height)
        )
        strokePath2.addCurve(
            to: CGPoint(x: 0.08333 * width, y: 0.47917 * height),
            control1: CGPoint(x: 0.26055 * width, y: 0.08333 * height),
            control2: CGPoint(x: 0.08333 * width, y: 0.26055 * height)
        )
        strokePath2.addCurve(
            to: CGPoint(x: 0.47917 * width, y: 0.875 * height),
            control1: CGPoint(x: 0.08333 * width, y: 0.69778 * height),
            control2: CGPoint(x: 0.26055 * width, y: 0.875 * height)
        )
        strokePath2.closeSubpath()

        path.addPath(
            strokePath2.strokedPath(
                StrokeStyle(
                    lineWidth: 0.0625 * width,
                    lineCap: .round,
                    lineJoin: .round,
                    miterLimit: 4
                )
            )
        )

        var strokePath4 = Path()
        strokePath4.move(to: CGPoint(x: 0.91667 * width, y: 0.91667 * height))
        strokePath4.addLine(to: CGPoint(x: 0.83333 * width, y: 0.83333 * height))

        path.addPath(
            strokePath4.strokedPath(
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
    SearchIcon()
        .fill(.black)
        .frame(width: 200, height: 200)
}
