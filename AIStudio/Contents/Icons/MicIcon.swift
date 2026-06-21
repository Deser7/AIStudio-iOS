//
//  MicIcon.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 21.06.2026.
//

import SwiftUI

struct MicIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        // MARK: - Capsule (mic head)
        path.move(to: CGPoint(x: 0.33333 * width, y: 0.20833 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.04167 * height),
            control1: CGPoint(x: 0.33333 * width, y: 0.11629 * height),
            control2: CGPoint(x: 0.40795 * width, y: 0.04167 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.66667 * width, y: 0.20833 * height),
            control1: CGPoint(x: 0.59205 * width, y: 0.04167 * height),
            control2: CGPoint(x: 0.66667 * width, y: 0.11629 * height)
        )
        path.addLine(to: CGPoint(x: 0.66667 * width, y: 0.5 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.66667 * height),
            control1: CGPoint(x: 0.66667 * width, y: 0.59205 * height),
            control2: CGPoint(x: 0.59205 * width, y: 0.66667 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.33333 * width, y: 0.5 * height),
            control1: CGPoint(x: 0.40795 * width, y: 0.66667 * height),
            control2: CGPoint(x: 0.33333 * width, y: 0.59205 * height)
        )
        path.closeSubpath()

        // MARK: - Inner hole
        path.move(to: CGPoint(x: 0.5 * width, y: 0.10417 * height))
        path.addCurve(
            to: CGPoint(x: 0.39583 * width, y: 0.20833 * height),
            control1: CGPoint(x: 0.44247 * width, y: 0.10417 * height),
            control2: CGPoint(x: 0.39583 * width, y: 0.1508 * height)
        )
        path.addLine(to: CGPoint(x: 0.39583 * width, y: 0.5 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.60417 * height),
            control1: CGPoint(x: 0.39583 * width, y: 0.55753 * height),
            control2: CGPoint(x: 0.44247 * width, y: 0.60417 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.60417 * width, y: 0.5 * height),
            control1: CGPoint(x: 0.55753 * width, y: 0.60417 * height),
            control2: CGPoint(x: 0.60417 * width, y: 0.55753 * height)
        )
        path.addLine(to: CGPoint(x: 0.60417 * width, y: 0.20833 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.10417 * height),
            control1: CGPoint(x: 0.60417 * width, y: 0.1508 * height),
            control2: CGPoint(x: 0.55753 * width, y: 0.10417 * height)
        )
        path.closeSubpath()

        // MARK: - Bottom arc + stem
        path.move(to: CGPoint(x: 0.21875 * width, y: 0.45833 * height))
        path.addCurve(
            to: CGPoint(x: 0.25 * width, y: 0.48958 * height),
            control1: CGPoint(x: 0.23601 * width, y: 0.45833 * height),
            control2: CGPoint(x: 0.25 * width, y: 0.47233 * height)
        )
        path.addLine(to: CGPoint(x: 0.25 * width, y: 0.5 * height))
        path.addCurve(
            to: CGPoint(x: 0.25086 * width, y: 0.52083 * height),
            control1: CGPoint(x: 0.25 * width, y: 0.50702 * height),
            control2: CGPoint(x: 0.25029 * width, y: 0.51396 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.75 * height),
            control1: CGPoint(x: 0.26144 * width, y: 0.64916 * height),
            control2: CGPoint(x: 0.36894 * width, y: 0.75 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.74915 * width, y: 0.52083 * height),
            control1: CGPoint(x: 0.63105 * width, y: 0.75 * height),
            control2: CGPoint(x: 0.73856 * width, y: 0.64916 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.75 * width, y: 0.5 * height),
            control1: CGPoint(x: 0.74971 * width, y: 0.51396 * height),
            control2: CGPoint(x: 0.75 * width, y: 0.50702 * height)
        )
        path.addLine(to: CGPoint(x: 0.75 * width, y: 0.48958 * height))
        path.addCurve(
            to: CGPoint(x: 0.78125 * width, y: 0.45833 * height),
            control1: CGPoint(x: 0.75 * width, y: 0.47233 * height),
            control2: CGPoint(x: 0.76399 * width, y: 0.45833 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.8125 * width, y: 0.48958 * height),
            control1: CGPoint(x: 0.79851 * width, y: 0.45833 * height),
            control2: CGPoint(x: 0.8125 * width, y: 0.47233 * height)
        )
        path.addLine(to: CGPoint(x: 0.8125 * width, y: 0.5 * height))
        path.addCurve(
            to: CGPoint(x: 0.53125 * width, y: 0.81096 * height),
            control1: CGPoint(x: 0.8125 * width, y: 0.66204 * height),
            control2: CGPoint(x: 0.68917 * width, y: 0.79528 * height)
        )
        path.addLine(to: CGPoint(x: 0.53125 * width, y: 0.92708 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.95833 * height),
            control1: CGPoint(x: 0.53125 * width, y: 0.94434 * height),
            control2: CGPoint(x: 0.51726 * width, y: 0.95833 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.92708 * height),
            control1: CGPoint(x: 0.48274 * width, y: 0.95833 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.94434 * height)
        )
        path.addLine(to: CGPoint(x: 0.46875 * width, y: 0.81096 * height))
        path.addCurve(
            to: CGPoint(x: 0.1875 * width, y: 0.5 * height),
            control1: CGPoint(x: 0.31083 * width, y: 0.79528 * height),
            control2: CGPoint(x: 0.1875 * width, y: 0.66204 * height)
        )
        path.addLine(to: CGPoint(x: 0.1875 * width, y: 0.48958 * height))
        path.addCurve(
            to: CGPoint(x: 0.21875 * width, y: 0.45833 * height),
            control1: CGPoint(x: 0.1875 * width, y: 0.47233 * height),
            control2: CGPoint(x: 0.20149 * width, y: 0.45833 * height)
        )
        path.closeSubpath()

        return path
    }
}

#Preview {
    MicIcon()
        .fill(.black, style: FillStyle(eoFill: true))
        .frame(width: 120, height: 120)
}
