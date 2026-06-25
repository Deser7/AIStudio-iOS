//
//  UserIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct UserIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        path.move(to: CGPoint(x: 0.75 * width, y: 0.22222 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.44444 * height),
            control1: CGPoint(x: 0.75 * width, y: 0.34495 * height),
            control2: CGPoint(x: 0.63807 * width, y: 0.44444 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.25 * width, y: 0.22222 * height),
            control1: CGPoint(x: 0.36193 * width, y: 0.44444 * height),
            control2: CGPoint(x: 0.25 * width, y: 0.34495 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0),
            control1: CGPoint(x: 0.25 * width, y: 0.09949 * height),
            control2: CGPoint(x: 0.36193 * width, y: 0)
        )
        path.addCurve(
            to: CGPoint(x: 0.75 * width, y: 0.22222 * height),
            control1: CGPoint(x: 0.63807 * width, y: 0),
            control2: CGPoint(x: 0.75 * width, y: 0.09949 * height)
        )
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.6875 * width, y: 0.22222 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.05556 * height),
            control1: CGPoint(x: 0.6875 * width, y: 0.13018 * height),
            control2: CGPoint(x: 0.60356 * width, y: 0.05556 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.3125 * width, y: 0.22222 * height),
            control1: CGPoint(x: 0.39644 * width, y: 0.05556 * height),
            control2: CGPoint(x: 0.3125 * width, y: 0.13018 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.38889 * height),
            control1: CGPoint(x: 0.3125 * width, y: 0.31427 * height),
            control2: CGPoint(x: 0.39644 * width, y: 0.38889 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.6875 * width, y: 0.22222 * height),
            control1: CGPoint(x: 0.60356 * width, y: 0.38889 * height),
            control2: CGPoint(x: 0.6875 * width, y: 0.31427 * height)
        )
        path.closeSubpath()

        path.move(to: CGPoint(x: width, y: 0.78703 * height))
        path.addCurve(
            to: CGPoint(x: 0.97384 * width, y: 0.72106 * height),
            control1: CGPoint(x: width, y: 0.76296 * height),
            control2: CGPoint(x: 0.99151 * width, y: 0.7393 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.52778 * height),
            control1: CGPoint(x: 0.85923 * width, y: 0.60271 * height),
            control2: CGPoint(x: 0.68946 * width, y: 0.52778 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.02615 * width, y: 0.72106 * height),
            control1: CGPoint(x: 0.31054 * width, y: 0.52778 * height),
            control2: CGPoint(x: 0.14077 * width, y: 0.60271 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0, y: 0.78703 * height),
            control1: CGPoint(x: 0.00848 * width, y: 0.7393 * height),
            control2: CGPoint(x: 0, y: 0.76296 * height)
        )
        path.addLine(to: CGPoint(x: 0, y: 0.88889 * height))
        path.addCurve(
            to: CGPoint(x: 0.125 * width, y: height),
            control1: CGPoint(x: 0, y: 0.95026 * height),
            control2: CGPoint(x: 0.05596 * width, y: height)
        )
        path.addLine(to: CGPoint(x: 0.875 * width, y: height))
        path.addCurve(
            to: CGPoint(x: width, y: 0.88889 * height),
            control1: CGPoint(x: 0.94404 * width, y: height),
            control2: CGPoint(x: width, y: 0.95026 * height)
        )
        path.addLine(to: CGPoint(x: width, y: 0.78703 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.875 * width, y: 0.94444 * height))
        path.addLine(to: CGPoint(x: 0.125 * width, y: 0.94444 * height))
        path.addCurve(
            to: CGPoint(x: 0.0625 * width, y: 0.88889 * height),
            control1: CGPoint(x: 0.09048 * width, y: 0.94444 * height),
            control2: CGPoint(x: 0.0625 * width, y: 0.91957 * height)
        )
        path.addLine(to: CGPoint(x: 0.0625 * width, y: 0.78703 * height))
        path.addCurve(
            to: CGPoint(x: 0.07352 * width, y: 0.7573 * height),
            control1: CGPoint(x: 0.0625 * width, y: 0.77426 * height),
            control2: CGPoint(x: 0.06699 * width, y: 0.76404 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.58333 * height),
            control1: CGPoint(x: 0.17677 * width, y: 0.65069 * height),
            control2: CGPoint(x: 0.3295 * width, y: 0.58333 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.92648 * width, y: 0.7573 * height),
            control1: CGPoint(x: 0.6705 * width, y: 0.58333 * height),
            control2: CGPoint(x: 0.82323 * width, y: 0.65069 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.9375 * width, y: 0.78703 * height),
            control1: CGPoint(x: 0.93301 * width, y: 0.76404 * height),
            control2: CGPoint(x: 0.9375 * width, y: 0.77426 * height)
        )
        path.addLine(to: CGPoint(x: 0.9375 * width, y: 0.88889 * height))
        path.addCurve(
            to: CGPoint(x: 0.875 * width, y: 0.94444 * height),
            control1: CGPoint(x: 0.9375 * width, y: 0.91957 * height),
            control2: CGPoint(x: 0.90952 * width, y: 0.94444 * height)
        )
        path.closeSubpath()

        return path
    }
}

#Preview {
    UserIcon()
        .fill(.black)
        .frame(width: 48, height: 48)
        .padding(24)
        .background(Color.background)
}
