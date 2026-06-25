//
//  PlusIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct PlusIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        var _hole2 = Path()
        _hole2.move(to: CGPoint(x: 0.46883*width, y: 0.84375*height))
        _hole2.addLine(to: CGPoint(x: 0.46883*width, y: 0.53124*height))
        _hole2.addLine(to: CGPoint(x: 0.15633*width, y: 0.53124*height))
        _hole2.addCurve(to: CGPoint(x: 0.12508*width, y: 0.49999*height), control1: CGPoint(x: 0.13907*width, y: 0.53124*height), control2: CGPoint(x: 0.12508*width, y: 0.51725*height))
        _hole2.addCurve(to: CGPoint(x: 0.15633*width, y: 0.46874*height), control1: CGPoint(x: 0.12508*width, y: 0.48273*height), control2: CGPoint(x: 0.13907*width, y: 0.46874*height))
        _hole2.addLine(to: CGPoint(x: 0.46883*width, y: 0.46874*height))
        _hole2.addLine(to: CGPoint(x: 0.46883*width, y: 0.15625*height))
        _hole2.addCurve(to: CGPoint(x: 0.50008*width, y: 0.125*height), control1: CGPoint(x: 0.46883*width, y: 0.13899*height), control2: CGPoint(x: 0.48282*width, y: 0.125*height))
        _hole2.addCurve(to: CGPoint(x: 0.53133*width, y: 0.15625*height), control1: CGPoint(x: 0.51734*width, y: 0.125*height), control2: CGPoint(x: 0.53133*width, y: 0.13899*height))
        _hole2.addLine(to: CGPoint(x: 0.53133*width, y: 0.46874*height))
        _hole2.addLine(to: CGPoint(x: 0.84383*width, y: 0.46874*height))
        _hole2.addCurve(to: CGPoint(x: 0.87508*width, y: 0.49999*height), control1: CGPoint(x: 0.86108*width, y: 0.46874*height), control2: CGPoint(x: 0.87508*width, y: 0.48273*height))
        _hole2.addCurve(to: CGPoint(x: 0.84383*width, y: 0.53124*height), control1: CGPoint(x: 0.87508*width, y: 0.51725*height), control2: CGPoint(x: 0.86108*width, y: 0.53124*height))
        _hole2.addLine(to: CGPoint(x: 0.53133*width, y: 0.53124*height))
        _hole2.addLine(to: CGPoint(x: 0.53133*width, y: 0.84375*height))
        _hole2.addCurve(to: CGPoint(x: 0.50008*width, y: 0.875*height), control1: CGPoint(x: 0.53133*width, y: 0.86101*height), control2: CGPoint(x: 0.51734*width, y: 0.875*height))
        _hole2.addCurve(to: CGPoint(x: 0.46883*width, y: 0.84375*height), control1: CGPoint(x: 0.48282*width, y: 0.875*height), control2: CGPoint(x: 0.46883*width, y: 0.86101*height))
        _hole2.closeSubpath()
        path.addPath(_hole2)
        return path
    }
}

#Preview {
    PlusIcon()
        .fill(Color.accent)
        .frame(width: 48, height: 48)
        .padding(24)
        .background(Color.background)
}
