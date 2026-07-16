//
//  DoctorIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct DoctorIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.375 * width, y: 0.375 * height))
        strokePath.addLine(to: CGPoint(x: 0.375 * width, y: 0.1875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.4375 * width, y: 0.125 * height),
            control1: CGPoint(x: 0.375 * width, y: 0.15298 * height),
            control2: CGPoint(x: 0.40298 * width, y: 0.125 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.5625 * width, y: 0.125 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.625 * width, y: 0.1875 * height),
            control1: CGPoint(x: 0.59702 * width, y: 0.125 * height),
            control2: CGPoint(x: 0.625 * width, y: 0.15298 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.625 * width, y: 0.375 * height))
        strokePath.addLine(to: CGPoint(x: 0.8125 * width, y: 0.375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.875 * width, y: 0.4375 * height),
            control1: CGPoint(x: 0.84702 * width, y: 0.375 * height),
            control2: CGPoint(x: 0.875 * width, y: 0.40298 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.875 * width, y: 0.5625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.8125 * width, y: 0.625 * height),
            control1: CGPoint(x: 0.875 * width, y: 0.59702 * height),
            control2: CGPoint(x: 0.84702 * width, y: 0.625 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.625 * width, y: 0.625 * height))
        strokePath.addLine(to: CGPoint(x: 0.625 * width, y: 0.8125 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.5625 * width, y: 0.875 * height),
            control1: CGPoint(x: 0.625 * width, y: 0.84702 * height),
            control2: CGPoint(x: 0.59702 * width, y: 0.875 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.4375 * width, y: 0.875 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.375 * width, y: 0.8125 * height),
            control1: CGPoint(x: 0.40298 * width, y: 0.875 * height),
            control2: CGPoint(x: 0.375 * width, y: 0.84702 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.375 * width, y: 0.625 * height))
        strokePath.addLine(to: CGPoint(x: 0.1875 * width, y: 0.625 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.125 * width, y: 0.5625 * height),
            control1: CGPoint(x: 0.15298 * width, y: 0.625 * height),
            control2: CGPoint(x: 0.125 * width, y: 0.59702 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.125 * width, y: 0.4375 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.1875 * width, y: 0.375 * height),
            control1: CGPoint(x: 0.125 * width, y: 0.40298 * height),
            control2: CGPoint(x: 0.15298 * width, y: 0.375 * height)
        )
        strokePath.addLine(to: CGPoint(x: 0.375 * width, y: 0.375 * height))
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
    DoctorIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
