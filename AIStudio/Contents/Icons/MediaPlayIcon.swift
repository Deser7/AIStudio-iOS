//
//  MediaPlayIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import SwiftUI

struct MediaPlayIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        var _hole2 = Path()
                _hole2.move(to: CGPoint(x: 0.9*width, y: 0.33955*height))
                _hole2.addCurve(to: CGPoint(x: 0.9*width, y: 0.65447*height), control1: CGPoint(x: 1.03333*width, y: 0.40953*height), control2: CGPoint(x: 1.03333*width, y: 0.58449*height))
                _hole2.addLine(to: CGPoint(x: 0.3*width, y: 0.96938*height))
                _hole2.addCurve(to: CGPoint(x: 0, y: 0.81193*height), control1: CGPoint(x: 0.16667*width, y: 1.03936*height), control2: CGPoint(x: 0, y: 0.95189*height))
                _hole2.addLine(to: CGPoint(x: 0, y: 0.18209*height))
                _hole2.addCurve(to: CGPoint(x: 0.3*width, y: 0.02463*height), control1: CGPoint(x: 0, y: 0.04213*height), control2: CGPoint(x: 0.16667*width, y: -0.04535*height))
                _hole2.addLine(to: CGPoint(x: 0.9*width, y: 0.33955*height))
                _hole2.closeSubpath()
                path.addPath(_hole2)

        return path
    }
}

#Preview {
    MediaPlayIcon()
        .fill(.black)
        .frame(width: 48, height: 48)
}
