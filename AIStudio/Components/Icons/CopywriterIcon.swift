//
//  CopywriterIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct CopywriterIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.8125 * width, y: 0.5 * height))
        strokePath.addLine(to: CGPoint(x: 0.88793 * width, y: 0.42455 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.88793 * width, y: 0.33616 * height),
            control1: CGPoint(x: 0.91234 * width, y: 0.40014 * height),
            control2: CGPoint(x: 0.91234 * width, y: 0.36057 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.66382 * width, y: 0.11205 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.57543 * width, y: 0.11205 * height),
            control1: CGPoint(x: 0.63942 * width, y: 0.08764 * height),
            control2: CGPoint(x: 0.59984 * width, y: 0.08764 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.5 * width, y: 0.1875 * height))

        strokePath.move(to: CGPoint(x: 0.8125 * width, y: 0.5 * height))
        strokePath.addLine(to: CGPoint(x: 0.5 * width, y: 0.1875 * height))

        strokePath.move(to: CGPoint(x: 0.5 * width, y: 0.1875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.15885 * width, y: 0.44876 * height),
            control1: CGPoint(x: 0.34225 * width, y: 0.16997 * height),
            control2: CGPoint(x: 0.18494 * width, y: 0.2922 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.09476 * width, y: 0.83332 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.11221 * width, y: 0.88779 * height),
            control1: CGPoint(x: 0.09123 * width, y: 0.85447 * height),
            control2: CGPoint(x: 0.09864 * width, y: 0.87421 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.16668 * width, y: 0.90524 * height),
            control1: CGPoint(x: 0.12579 * width, y: 0.90136 * height),
            control2: CGPoint(x: 0.14553 * width, y: 0.90877 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.55124 * width, y: 0.84115 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.8125 * width, y: 0.5 * height),
            control1: CGPoint(x: 0.7078 * width, y: 0.81505 * height),
            control2: CGPoint(x: 0.83003 * width, y: 0.65775 * height)
        )

        strokePath.move(to: CGPoint(x: 0.40246 * width, y: 0.59754 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.375 * width, y: 0.53125 * height),
            control1: CGPoint(x: 0.38549 * width, y: 0.58057 * height),
            control2: CGPoint(x: 0.375 * width, y: 0.55714 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.4375 * height),
            control1: CGPoint(x: 0.375 * width, y: 0.47947 * height),
            control2: CGPoint(x: 0.41697 * width, y: 0.4375 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.5625 * width, y: 0.53125 * height),
            control1: CGPoint(x: 0.52053 * width, y: 0.4375 * height),
            control2: CGPoint(x: 0.5625 * width, y: 0.47947 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.625 * height),
            control1: CGPoint(x: 0.5625 * width, y: 0.58303 * height),
            control2: CGPoint(x: 0.52053 * width, y: 0.625 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.40246 * width, y: 0.59754 * height),
            control1: CGPoint(x: 0.44286 * width, y: 0.625 * height),
            control2: CGPoint(x: 0.41942 * width, y: 0.6145 * height)
        )
        strokePath.closeSubpath()

        strokePath.move(to: CGPoint(x: 0.40246 * width, y: 0.59754 * height))
        strokePath.addLine(to: CGPoint(x: 0.11221 * width, y: 0.88779 * height))

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
    CopywriterIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
