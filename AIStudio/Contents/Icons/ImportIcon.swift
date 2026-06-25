//
//  ImportIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct ImportIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        // Arrow head
        path.move(to: CGPoint(x: 0.38834 * width, y: 0.48667 * height))
        path.addLine(to: CGPoint(x: 0.495 * width, y: 0.59333 * height))
        path.addLine(to: CGPoint(x: 0.60167 * width, y: 0.48667 * height))

        // Arrow stem
        path.move(to: CGPoint(x: 0.495 * width, y: 0.16667 * height))
        path.addLine(to: CGPoint(x: 0.495 * width, y: 0.59042 * height))

        // Bottom arc
        path.move(to: CGPoint(x: 0.83333 * width, y: 0.5075 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.84083 * height),
            control1: CGPoint(x: 0.83333 * width, y: 0.69167 * height),
            control2: CGPoint(x: 0.70833 * width, y: 0.84083 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.16667 * width, y: 0.5075 * height),
            control1: CGPoint(x: 0.29167 * width, y: 0.84083 * height),
            control2: CGPoint(x: 0.16667 * width, y: 0.69167 * height)
        )

        return path
    }
}

#Preview {
    ImportIcon()
        .stroke(
            .black,
            style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
        )
        .frame(width: 48, height: 48)
        .padding(24)
        .background(Color.background)
}
