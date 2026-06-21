//
//  SettingsIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct SettingsIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        var path = Path()

        path.move(to: CGPoint(x: 0.5 * w, y: 0.625 * h))
        path.addCurve(
            to: CGPoint(x: 0.625 * w, y: 0.5 * h),
            control1: CGPoint(x: 0.56903 * w, y: 0.625 * h),
            control2: CGPoint(x: 0.625 * w, y: 0.56903 * h)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * w, y: 0.375 * h),
            control1: CGPoint(x: 0.625 * w, y: 0.43097 * h),
            control2: CGPoint(x: 0.56903 * w, y: 0.375 * h)
        )
        path.addCurve(
            to: CGPoint(x: 0.375 * w, y: 0.5 * h),
            control1: CGPoint(x: 0.43097 * w, y: 0.375 * h),
            control2: CGPoint(x: 0.375 * w, y: 0.43097 * h)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * w, y: 0.625 * h),
            control1: CGPoint(x: 0.375 * w, y: 0.56903 * h),
            control2: CGPoint(x: 0.43097 * w, y: 0.625 * h)
        )

        path.move(to: CGPoint(x: 0.08334 * w, y: 0.53667 * h))
        path.addLine(to: CGPoint(x: 0.08334 * w, y: 0.46333 * h))

        path.addCurve(
            to: CGPoint(x: 0.1625 * w, y: 0.38417 * h),
            control1: CGPoint(x: 0.08334 * w, y: 0.42 * h),
            control2: CGPoint(x: 0.11875 * w, y: 0.38417 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.23084 * w, y: 0.26542 * h),
            control1: CGPoint(x: 0.23792 * w, y: 0.38417 * h),
            control2: CGPoint(x: 0.26875 * w, y: 0.33083 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.26 * w, y: 0.1575 * h),
            control1: CGPoint(x: 0.20917 * w, y: 0.22792 * h),
            control2: CGPoint(x: 0.22209 * w, y: 0.17917 * h)
        )

        path.addLine(to: CGPoint(x: 0.33208 * w, y: 0.11625 * h))

        path.addCurve(
            to: CGPoint(x: 0.42708 * w, y: 0.14125 * h),
            control1: CGPoint(x: 0.365 * w, y: 0.09667 * h),
            control2: CGPoint(x: 0.4075 * w, y: 0.10833 * h)
        )

        path.addLine(to: CGPoint(x: 0.43167 * w, y: 0.14917 * h))

        path.addCurve(
            to: CGPoint(x: 0.56875 * w, y: 0.14917 * h),
            control1: CGPoint(x: 0.46917 * w, y: 0.21458 * h),
            control2: CGPoint(x: 0.53083 * w, y: 0.21458 * h)
        )

        path.addLine(to: CGPoint(x: 0.57333 * w, y: 0.14125 * h))

        path.addCurve(
            to: CGPoint(x: 0.66833 * w, y: 0.11625 * h),
            control1: CGPoint(x: 0.59292 * w, y: 0.10833 * h),
            control2: CGPoint(x: 0.63542 * w, y: 0.09667 * h)
        )

        path.addLine(to: CGPoint(x: 0.74042 * w, y: 0.1575 * h))

        path.addCurve(
            to: CGPoint(x: 0.76958 * w, y: 0.26542 * h),
            control1: CGPoint(x: 0.77833 * w, y: 0.17917 * h),
            control2: CGPoint(x: 0.79125 * w, y: 0.22792 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.83792 * w, y: 0.38417 * h),
            control1: CGPoint(x: 0.73167 * w, y: 0.33083 * h),
            control2: CGPoint(x: 0.7625 * w, y: 0.38417 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.91708 * w, y: 0.46333 * h),
            control1: CGPoint(x: 0.88125 * w, y: 0.38417 * h),
            control2: CGPoint(x: 0.91708 * w, y: 0.41958 * h)
        )

        path.addLine(to: CGPoint(x: 0.91708 * w, y: 0.53667 * h))

        path.addCurve(
            to: CGPoint(x: 0.83792 * w, y: 0.61583 * h),
            control1: CGPoint(x: 0.91708 * w, y: 0.58 * h),
            control2: CGPoint(x: 0.88167 * w, y: 0.61583 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.76958 * w, y: 0.73458 * h),
            control1: CGPoint(x: 0.7625 * w, y: 0.61583 * h),
            control2: CGPoint(x: 0.73167 * w, y: 0.66917 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.74042 * w, y: 0.8425 * h),
            control1: CGPoint(x: 0.79125 * w, y: 0.7725 * h),
            control2: CGPoint(x: 0.77833 * w, y: 0.82083 * h)
        )

        path.addLine(to: CGPoint(x: 0.66833 * w, y: 0.88375 * h))

        path.addCurve(
            to: CGPoint(x: 0.57333 * w, y: 0.85875 * h),
            control1: CGPoint(x: 0.63542 * w, y: 0.90333 * h),
            control2: CGPoint(x: 0.59292 * w, y: 0.89167 * h)
        )

        path.addLine(to: CGPoint(x: 0.56875 * w, y: 0.85083 * h))

        path.addCurve(
            to: CGPoint(x: 0.43167 * w, y: 0.85083 * h),
            control1: CGPoint(x: 0.53125 * w, y: 0.78542 * h),
            control2: CGPoint(x: 0.46958 * w, y: 0.78542 * h)
        )

        path.addLine(to: CGPoint(x: 0.42708 * w, y: 0.85875 * h))

        path.addCurve(
            to: CGPoint(x: 0.33208 * w, y: 0.88375 * h),
            control1: CGPoint(x: 0.4075 * w, y: 0.89167 * h),
            control2: CGPoint(x: 0.365 * w, y: 0.90333 * h)
        )

        path.addLine(to: CGPoint(x: 0.26 * w, y: 0.8425 * h))

        path.addCurve(
            to: CGPoint(x: 0.23084 * w, y: 0.73458 * h),
            control1: CGPoint(x: 0.22209 * w, y: 0.82083 * h),
            control2: CGPoint(x: 0.20917 * w, y: 0.77208 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.1625 * w, y: 0.61583 * h),
            control1: CGPoint(x: 0.26875 * w, y: 0.66917 * h),
            control2: CGPoint(x: 0.23792 * w, y: 0.61583 * h)
        )

        path.addCurve(
            to: CGPoint(x: 0.08334 * w, y: 0.53667 * h),
            control1: CGPoint(x: 0.11875 * w, y: 0.61583 * h),
            control2: CGPoint(x: 0.08334 * w, y: 0.58 * h)
        )

        return path
    }
}

#Preview {
    SettingsIcon()
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
