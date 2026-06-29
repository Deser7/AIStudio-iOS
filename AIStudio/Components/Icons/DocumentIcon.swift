//
//  DocumentIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct DocumentIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        
        var strokePath2 = Path()
        strokePath2.move(to: CGPoint(x: 0.91667*width, y: 0.41667*height))
        strokePath2.addLine(to: CGPoint(x: 0.91667*width, y: 0.625*height))
        strokePath2.addCurve(to: CGPoint(x: 0.625*width, y: 0.91667*height), control1: CGPoint(x: 0.91667*width, y: 0.83333*height), control2: CGPoint(x: 0.83333*width, y: 0.91667*height))
        strokePath2.addLine(to: CGPoint(x: 0.375*width, y: 0.91667*height))
        strokePath2.addCurve(to: CGPoint(x: 0.08334*width, y: 0.625*height), control1: CGPoint(x: 0.16667*width, y: 0.91667*height), control2: CGPoint(x: 0.08334*width, y: 0.83333*height))
        strokePath2.addLine(to: CGPoint(x: 0.08334*width, y: 0.375*height))
        strokePath2.addCurve(to: CGPoint(x: 0.375*width, y: 0.08333*height), control1: CGPoint(x: 0.08334*width, y: 0.16667*height), control2: CGPoint(x: 0.16667*width, y: 0.08333*height))
        strokePath2.addLine(to: CGPoint(x: 0.58333*width, y: 0.08333*height))
        path.addPath(strokePath2.strokedPath(StrokeStyle(lineWidth: 0.0625*width, lineCap: .round, lineJoin: .round, miterLimit: 4)))
        var strokePath4 = Path()
        strokePath4.move(to: CGPoint(x: 0.91667*width, y: 0.41667*height))
        strokePath4.addLine(to: CGPoint(x: 0.75*width, y: 0.41667*height))
        strokePath4.addCurve(to: CGPoint(x: 0.58333*width, y: 0.25*height), control1: CGPoint(x: 0.625*width, y: 0.41667*height), control2: CGPoint(x: 0.58333*width, y: 0.375*height))
        strokePath4.addLine(to: CGPoint(x: 0.58333*width, y: 0.08333*height))
        strokePath4.addLine(to: CGPoint(x: 0.91667*width, y: 0.41667*height))
        strokePath4.closeSubpath()
        path.addPath(strokePath4.strokedPath(StrokeStyle(lineWidth: 0.0625*width, lineCap: .round, lineJoin: .round, miterLimit: 4)))
        return path
    }
}

#Preview {
    DocumentIcon()
        .fill(AppGradient.main)
        .frame(width: 32, height: 32)
}
