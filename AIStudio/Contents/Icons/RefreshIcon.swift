//
//  RefreshIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct RefreshIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        path.move(to: CGPoint(x: 0.91667 * width, y: 0.5 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.91667 * height),
            control1: CGPoint(x: 0.91667 * width, y: 0.73 * height),
            control2: CGPoint(x: 0.73 * width, y: 0.91667 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.12958 * width, y: 0.685 * height),
            control1: CGPoint(x: 0.27 * width, y: 0.91667 * height),
            control2: CGPoint(x: 0.12958 * width, y: 0.685 * height)
        )

        path.move(to: CGPoint(x: 0.12958 * width, y: 0.89333 * height))
        path.addLine(to: CGPoint(x: 0.12958 * width, y: 0.685 * height))
        path.addLine(to: CGPoint(x: 0.31792 * width, y: 0.685 * height))

        path.move(to: CGPoint(x: 0.08333 * width, y: 0.5 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.08333 * height),
            control1: CGPoint(x: 0.08333 * width, y: 0.27 * height),
            control2: CGPoint(x: 0.26833 * width, y: 0.08333 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.91667 * width, y: 0.315 * height),
            control1: CGPoint(x: 0.77792 * width, y: 0.08333 * height),
            control2: CGPoint(x: 0.91667 * width, y: 0.315 * height)
        )

        path.move(to: CGPoint(x: 0.73167 * width, y: 0.315 * height))
        path.addLine(to: CGPoint(x: 0.91667 * width, y: 0.315 * height))
        path.addLine(to: CGPoint(x: 0.91667 * width, y: 0.10667 * height))

        return path
    }
}

#Preview {
    RefreshIcon()
        .stroke(
            .black,
            style: StrokeStyle(
                lineWidth: 8,
                lineCap: .round,
                lineJoin: .round
            )
        )
        .frame(width: 200, height: 200)
}
