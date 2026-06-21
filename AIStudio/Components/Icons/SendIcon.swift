//
//  SendIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct SendIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        var path = Path()

        path.move(to: CGPoint(x: 0.30833 * w, y: 0.26333 * h))
        path.addLine(to: CGPoint(x: 0.66208 * w, y: 0.14542 * h))

        path.addCurve(
            to: CGPoint(x: 0.85458 * w, y: 0.33792 * h),
            control1: CGPoint(x: 0.82083 * w, y: 0.0925 * h),
            control2: CGPoint(x: 0.90708 * w, y: 0.17917 * h)
        )

        path.addLine(to: CGPoint(x: 0.73666 * w, y: 0.69167 * h))

        path.addCurve(
            to: CGPoint(x: 0.44833 * w, y: 0.69167 * h),
            control1: CGPoint(x: 0.6575 * w, y: 0.92958 * h),
            control2: CGPoint(x: 0.5275 * w, y: 0.92958 * h)
        )

        path.addLine(to: CGPoint(x: 0.41333 * w, y: 0.58667 * h))
        path.addLine(to: CGPoint(x: 0.30833 * w, y: 0.55167 * h))

        path.addCurve(
            to: CGPoint(x: 0.30833 * w, y: 0.26333 * h),
            control1: CGPoint(x: 0.07041 * w, y: 0.4725 * h),
            control2: CGPoint(x: 0.07041 * w, y: 0.34292 * h)
        )

        path.move(to: CGPoint(x: 0.42125 * w, y: 0.56875 * h))
        path.addLine(to: CGPoint(x: 0.57042 * w, y: 0.41917 * h))

        return path
    }
}

#Preview {
    SendIcon()
        .stroke(
            .black,
            style: StrokeStyle(
                lineWidth: 5,
                lineCap: .round,
                lineJoin: .round
            )
        )
        .frame(width: 200, height: 200)
}
