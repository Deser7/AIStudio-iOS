//
//  CopyIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct CopyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        var hole2 = Path()
        hole2.move(to: CGPoint(x: 0.66667 * width, y: 0.5375 * height))
        hole2.addLine(to: CGPoint(x: 0.66667 * width, y: 0.7125 * height))
        hole2.addCurve(
            to: CGPoint(x: 0.4625 * width, y: 0.91667 * height),
            control1: CGPoint(x: 0.66667 * width, y: 0.85833 * height),
            control2: CGPoint(x: 0.60833 * width, y: 0.91667 * height)
        )
        hole2.addLine(to: CGPoint(x: 0.2875 * width, y: 0.91667 * height))
        hole2.addCurve(
            to: CGPoint(x: 0.08333 * width, y: 0.7125 * height),
            control1: CGPoint(x: 0.14167 * width, y: 0.91667 * height),
            control2: CGPoint(x: 0.08333 * width, y: 0.85833 * height)
        )
        hole2.addLine(to: CGPoint(x: 0.08333 * width, y: 0.5375 * height))
        hole2.addCurve(
            to: CGPoint(x: 0.2875 * width, y: 0.33333 * height),
            control1: CGPoint(x: 0.08333 * width, y: 0.39167 * height),
            control2: CGPoint(x: 0.14167 * width, y: 0.33333 * height)
        )
        hole2.addLine(to: CGPoint(x: 0.4625 * width, y: 0.33333 * height))
        hole2.addCurve(
            to: CGPoint(x: 0.66667 * width, y: 0.5375 * height),
            control1: CGPoint(x: 0.60833 * width, y: 0.33333 * height),
            control2: CGPoint(x: 0.66667 * width, y: 0.39167 * height)
        )
        hole2.closeSubpath()
        path.addPath(hole2)

        var hole4 = Path()
        hole4.move(to: CGPoint(x: 0.91667 * width, y: 0.2875 * height))
        hole4.addLine(to: CGPoint(x: 0.91667 * width, y: 0.4625 * height))
        hole4.addCurve(
            to: CGPoint(x: 0.7125 * width, y: 0.66667 * height),
            control1: CGPoint(x: 0.91667 * width, y: 0.60833 * height),
            control2: CGPoint(x: 0.85833 * width, y: 0.66667 * height)
        )
        hole4.addLine(to: CGPoint(x: 0.66667 * width, y: 0.66667 * height))
        hole4.addLine(to: CGPoint(x: 0.66667 * width, y: 0.5375 * height))
        hole4.addCurve(
            to: CGPoint(x: 0.4625 * width, y: 0.33333 * height),
            control1: CGPoint(x: 0.66667 * width, y: 0.39167 * height),
            control2: CGPoint(x: 0.60833 * width, y: 0.33333 * height)
        )
        hole4.addLine(to: CGPoint(x: 0.33333 * width, y: 0.33333 * height))
        hole4.addLine(to: CGPoint(x: 0.33333 * width, y: 0.2875 * height))
        hole4.addCurve(
            to: CGPoint(x: 0.5375 * width, y: 0.08333 * height),
            control1: CGPoint(x: 0.33333 * width, y: 0.14167 * height),
            control2: CGPoint(x: 0.39167 * width, y: 0.08333 * height)
        )
        hole4.addLine(to: CGPoint(x: 0.7125 * width, y: 0.08333 * height))
        hole4.addCurve(
            to: CGPoint(x: 0.91667 * width, y: 0.2875 * height),
            control1: CGPoint(x: 0.85833 * width, y: 0.08333 * height),
            control2: CGPoint(x: 0.91667 * width, y: 0.14167 * height)
        )
        hole4.closeSubpath()
        path.addPath(hole4)

        return path
    }
}

#Preview {
    CopyIcon()
        .stroke(.black, lineWidth: 4)
        .frame(width: 48, height: 48)
}
