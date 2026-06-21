//
//  PaperPlaneIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct PaperPlaneIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        path.move(to: CGPoint(x: 0.85824 * width, y: 0.21198 * height))
        path.addCurve(
            to: CGPoint(x: 0.8759 * width, y: 0.21857 * height),
            control1: CGPoint(x: 0.86442 * width, y: 0.21278 * height),
            control2: CGPoint(x: 0.87049 * width, y: 0.21498 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.8824 * width, y: 0.2239 * height),
            control1: CGPoint(x: 0.8782 * width, y: 0.22011 * height),
            control2: CGPoint(x: 0.8804 * width, y: 0.22188 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.8822 * width, y: 0.28282 * height),
            control1: CGPoint(x: 0.89863 * width, y: 0.24022 * height),
            control2: CGPoint(x: 0.89852 * width, y: 0.2666 * height)
        )

        path.addLine(to: CGPoint(x: 0.40344 * width, y: 0.75873 * height))

        path.addCurve(
            to: CGPoint(x: 0.34469 * width, y: 0.75873 * height),
            control1: CGPoint(x: 0.38719 * width, y: 0.77488 * height),
            control2: CGPoint(x: 0.36094 * width, y: 0.77488 * height)
        )

        path.addLine(to: CGPoint(x: 0.1178 * width, y: 0.53335 * height))

        path.addCurve(
            to: CGPoint(x: 0.11764 * width, y: 0.47439 * height),
            control1: CGPoint(x: 0.10147 * width, y: 0.51713 * height),
            control2: CGPoint(x: 0.10142 * width, y: 0.49072 * height)
        )

        path.addCurve(
            to: CGPoint(x: 0.17655 * width, y: 0.47423 * height),
            control1: CGPoint(x: 0.13385 * width, y: 0.45808 * height),
            control2: CGPoint(x: 0.16023 * width, y: 0.45802 * height)
        )

        path.addLine(to: CGPoint(x: 0.37402 * width, y: 0.6704 * height))
        path.addLine(to: CGPoint(x: 0.82349 * width, y: 0.22374 * height))

        path.addCurve(
            to: CGPoint(x: 0.849 * width, y: 0.21178 * height),
            control1: CGPoint(x: 0.83062 * width, y: 0.21665 * height),
            control2: CGPoint(x: 0.8397 * width, y: 0.21264 * height)
        )

        path.addCurve(
            to: CGPoint(x: 0.85824 * width, y: 0.21198 * height),
            control1: CGPoint(x: 0.85207 * width, y: 0.21149 * height),
            control2: CGPoint(x: 0.85518 * width, y: 0.21158 * height)
        )

        path.closeSubpath()

        return path
    }
}

#Preview {
    PaperPlaneIcon()
        .fill(.black, style: FillStyle(eoFill: true))
        .frame(width: 120, height: 120)
}
