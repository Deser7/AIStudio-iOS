//
//  GenerateIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct GenerateIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        var hole2 = Path()
        hole2.move(to: CGPoint(x: 0.30998 * width, y: 0.15975 * height))
        hole2.addCurve(to: CGPoint(x: 0.39835 * width, y: 0.15975 * height), control1: CGPoint(x: 0.32121 * width, y: 0.11342 * height), control2: CGPoint(x: 0.38712 * width, y: 0.11342 * height))
        hole2.addLine(to: CGPoint(x: 0.42927 * width, y: 0.28726 * height))
        hole2.addCurve(to: CGPoint(x: 0.46275 * width, y: 0.32073 * height), control1: CGPoint(x: 0.43328 * width, y: 0.3038 * height), control2: CGPoint(x: 0.4462 * width, y: 0.31672 * height))
        hole2.addLine(to: CGPoint(x: 0.59025 * width, y: 0.35165 * height))
        hole2.addCurve(to: CGPoint(x: 0.59025 * width, y: 0.44002 * height), control1: CGPoint(x: 0.63658 * width, y: 0.36288 * height), control2: CGPoint(x: 0.63658 * width, y: 0.42878 * height))
        hole2.addLine(to: CGPoint(x: 0.46275 * width, y: 0.47094 * height))
        hole2.addCurve(to: CGPoint(x: 0.42927 * width, y: 0.50441 * height), control1: CGPoint(x: 0.4462 * width, y: 0.47495 * height), control2: CGPoint(x: 0.43328 * width, y: 0.48787 * height))
        hole2.addLine(to: CGPoint(x: 0.39835 * width, y: 0.63191 * height))
        hole2.addCurve(to: CGPoint(x: 0.30998 * width, y: 0.63191 * height), control1: CGPoint(x: 0.38712 * width, y: 0.67825 * height), control2: CGPoint(x: 0.32121 * width, y: 0.67825 * height))
        hole2.addLine(to: CGPoint(x: 0.27906 * width, y: 0.50441 * height))
        hole2.addCurve(to: CGPoint(x: 0.24559 * width, y: 0.47094 * height), control1: CGPoint(x: 0.27505 * width, y: 0.48787 * height), control2: CGPoint(x: 0.26213 * width, y: 0.47495 * height))
        hole2.addLine(to: CGPoint(x: 0.11809 * width, y: 0.44002 * height))
        hole2.addCurve(to: CGPoint(x: 0.11809 * width, y: 0.35165 * height), control1: CGPoint(x: 0.07175 * width, y: 0.42878 * height), control2: CGPoint(x: 0.07175 * width, y: 0.36288 * height))
        hole2.addLine(to: CGPoint(x: 0.24559 * width, y: 0.32073 * height))
        hole2.addCurve(to: CGPoint(x: 0.27906 * width, y: 0.28726 * height), control1: CGPoint(x: 0.26213 * width, y: 0.31672 * height), control2: CGPoint(x: 0.27505 * width, y: 0.3038 * height))
        hole2.addLine(to: CGPoint(x: 0.30998 * width, y: 0.15975 * height))
        hole2.closeSubpath()
        path.addPath(hole2)

        var hole4 = Path()
        hole4.move(to: CGPoint(x: 0.68114 * width, y: 0.60472 * height))
        hole4.addCurve(to: CGPoint(x: 0.73552 * width, y: 0.60472 * height), control1: CGPoint(x: 0.68805 * width, y: 0.5762 * height), control2: CGPoint(x: 0.72861 * width, y: 0.5762 * height))
        hole4.addLine(to: CGPoint(x: 0.75455 * width, y: 0.68318 * height))
        hole4.addCurve(to: CGPoint(x: 0.77515 * width, y: 0.70378 * height), control1: CGPoint(x: 0.75702 * width, y: 0.69336 * height), control2: CGPoint(x: 0.76497 * width, y: 0.70131 * height))
        hole4.addLine(to: CGPoint(x: 0.85361 * width, y: 0.72281 * height))
        hole4.addCurve(to: CGPoint(x: 0.85361 * width, y: 0.77719 * height), control1: CGPoint(x: 0.88213 * width, y: 0.72972 * height), control2: CGPoint(x: 0.88213 * width, y: 0.77028 * height))
        hole4.addLine(to: CGPoint(x: 0.77515 * width, y: 0.79622 * height))
        hole4.addCurve(to: CGPoint(x: 0.75455 * width, y: 0.81682 * height), control1: CGPoint(x: 0.76497 * width, y: 0.79869 * height), control2: CGPoint(x: 0.75702 * width, y: 0.80664 * height))
        hole4.addLine(to: CGPoint(x: 0.73552 * width, y: 0.89528 * height))
        hole4.addCurve(to: CGPoint(x: 0.68114 * width, y: 0.89528 * height), control1: CGPoint(x: 0.72861 * width, y: 0.9238 * height), control2: CGPoint(x: 0.68805 * width, y: 0.9238 * height))
        hole4.addLine(to: CGPoint(x: 0.66212 * width, y: 0.81682 * height))
        hole4.addCurve(to: CGPoint(x: 0.64152 * width, y: 0.79622 * height), control1: CGPoint(x: 0.65965 * width, y: 0.80664 * height), control2: CGPoint(x: 0.6517 * width, y: 0.79869 * height))
        hole4.addLine(to: CGPoint(x: 0.56305 * width, y: 0.77719 * height))
        hole4.addCurve(to: CGPoint(x: 0.56305 * width, y: 0.72281 * height), control1: CGPoint(x: 0.53454 * width, y: 0.77028 * height), control2: CGPoint(x: 0.53454 * width, y: 0.72972 * height))
        hole4.addLine(to: CGPoint(x: 0.64152 * width, y: 0.70378 * height))
        hole4.addCurve(to: CGPoint(x: 0.66212 * width, y: 0.68318 * height), control1: CGPoint(x: 0.6517 * width, y: 0.70131 * height), control2: CGPoint(x: 0.65965 * width, y: 0.69336 * height))
        hole4.addLine(to: CGPoint(x: 0.68114 * width, y: 0.60472 * height))
        hole4.closeSubpath()
        path.addPath(hole4)

        return path
    }
}

#Preview {
    GenerateIcon()
        .fill(.black)
        .frame(width: 48, height: 48)
}
