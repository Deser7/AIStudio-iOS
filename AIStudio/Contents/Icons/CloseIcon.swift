//
//  CloseIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct CloseIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        path.move(to: CGPoint(x: 0.74313 * width, y: 0.198 * height))
        path.addCurve(
            to: CGPoint(x: 0.80204 * width, y: 0.198 * height),
            control1: CGPoint(x: 0.75939 * width, y: 0.18173 * height),
            control2: CGPoint(x: 0.78577 * width, y: 0.18173 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.80204 * width, y: 0.25692 * height),
            control1: CGPoint(x: 0.81832 * width, y: 0.21427 * height),
            control2: CGPoint(x: 0.81832 * width, y: 0.24065 * height)
        )

        path.addLine(to: CGPoint(x: 0.55896 * width, y: 0.49996 * height))
        path.addLine(to: CGPoint(x: 0.80204 * width, y: 0.74304 * height))

        path.addCurve(
            to: CGPoint(x: 0.80204 * width, y: 0.802 * height),
            control1: CGPoint(x: 0.81832 * width, y: 0.75931 * height),
            control2: CGPoint(x: 0.81832 * width, y: 0.78573 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.74313 * width, y: 0.802 * height),
            control1: CGPoint(x: 0.78577 * width, y: 0.81825 * height),
            control2: CGPoint(x: 0.75939 * width, y: 0.81827 * height)
        )

        path.addLine(to: CGPoint(x: 0.50004 * width, y: 0.55888 * height))
        path.addLine(to: CGPoint(x: 0.257 * width, y: 0.80196 * height))

        path.addCurve(
            to: CGPoint(x: 0.25049 * width, y: 0.80729 * height),
            control1: CGPoint(x: 0.25497 * width, y: 0.80399 * height),
            control2: CGPoint(x: 0.25279 * width, y: 0.80577 * height)
        )

        path.addLine(to: CGPoint(x: 0.25049 * width, y: 0.80733 * height))

        path.addCurve(
            to: CGPoint(x: 0.19808 * width, y: 0.80196 * height),
            control1: CGPoint(x: 0.23431 * width, y: 0.81801 * height),
            control2: CGPoint(x: 0.21232 * width, y: 0.81621 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.19808 * width, y: 0.74304 * height),
            control1: CGPoint(x: 0.18181 * width, y: 0.78569 * height),
            control2: CGPoint(x: 0.18181 * width, y: 0.75931 * height)
        )

        path.addLine(to: CGPoint(x: 0.44112 * width, y: 0.49996 * height))
        path.addLine(to: CGPoint(x: 0.19808 * width, y: 0.25692 * height))

        path.addCurve(
            to: CGPoint(x: 0.19808 * width, y: 0.198 * height),
            control1: CGPoint(x: 0.18181 * width, y: 0.24065 * height),
            control2: CGPoint(x: 0.18181 * width, y: 0.21427 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.257 * width, y: 0.198 * height),
            control1: CGPoint(x: 0.21435 * width, y: 0.18173 * height),
            control2: CGPoint(x: 0.24073 * width, y: 0.18173 * height)
        )

        path.addLine(to: CGPoint(x: 0.50004 * width, y: 0.44104 * height))
        path.addLine(to: CGPoint(x: 0.74313 * width, y: 0.198 * height))
        path.closeSubpath()

        return path
    }
}

#Preview {
    CloseIcon()
        .fill(.black)
        .frame(width: 200, height: 200)
}
