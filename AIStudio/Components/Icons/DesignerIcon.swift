//
//  DesignerIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 16.07.2026.
//

import SwiftUI

struct DesignerIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        var strokePath = Path()

        strokePath.move(to: CGPoint(x: 0.64916 * width, y: 0.5 * height))
        strokePath.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.64917 * height),
            control1: CGPoint(x: 0.64916 * width, y: 0.5825 * height),
            control2: CGPoint(x: 0.5825 * width, y: 0.64917 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.35083 * width, y: 0.5 * height),
            control1: CGPoint(x: 0.4175 * width, y: 0.64917 * height),
            control2: CGPoint(x: 0.35083 * width, y: 0.5825 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.35083 * height),
            control1: CGPoint(x: 0.35083 * width, y: 0.4175 * height),
            control2: CGPoint(x: 0.4175 * width, y: 0.35083 * height)
        )
        strokePath.addCurve(
            to: CGPoint(x: 0.64916 * width, y: 0.5 * height),
            control1: CGPoint(x: 0.5825 * width, y: 0.35083 * height),
            control2: CGPoint(x: 0.64916 * width, y: 0.4175 * height)
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

        var outerPath = Path()

        outerPath.move(to: CGPoint(x: 0.5 * width, y: 0.84458 * height))
        outerPath.addCurve(
            to: CGPoint(x: 0.87959 * width, y: 0.60792 * height),
            control1: CGPoint(x: 0.64709 * width, y: 0.84458 * height),
            control2: CGPoint(x: 0.78417 * width, y: 0.75792 * height)
        )
        outerPath.addCurve(
            to: CGPoint(x: 0.87959 * width, y: 0.39167 * height),
            control1: CGPoint(x: 0.91709 * width, y: 0.54917 * height),
            control2: CGPoint(x: 0.91709 * width, y: 0.45042 * height)
        )
        outerPath.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.155 * height),
            control1: CGPoint(x: 0.78417 * width, y: 0.24167 * height),
            control2: CGPoint(x: 0.64709 * width, y: 0.155 * height)
        )
        outerPath.addCurve(
            to: CGPoint(x: 0.12042 * width, y: 0.39167 * height),
            control1: CGPoint(x: 0.35292 * width, y: 0.155 * height),
            control2: CGPoint(x: 0.21584 * width, y: 0.24167 * height)
        )
        outerPath.addCurve(
            to: CGPoint(x: 0.12042 * width, y: 0.60792 * height),
            control1: CGPoint(x: 0.08292 * width, y: 0.45042 * height),
            control2: CGPoint(x: 0.08292 * width, y: 0.54917 * height)
        )
        outerPath.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.84458 * height),
            control1: CGPoint(x: 0.21584 * width, y: 0.75792 * height),
            control2: CGPoint(x: 0.35292 * width, y: 0.84458 * height)
        )
        outerPath.closeSubpath()

        path.addPath(
            outerPath.strokedPath(
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
    DesignerIcon()
        .fill(.primary)
        .frame(width: 100, height: 100)
        .padding()
}
