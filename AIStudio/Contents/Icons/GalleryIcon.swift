//
//  GalleryIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct GalleryIcon: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        
        var strokePath2 = Path()
        strokePath2.move(to: CGPoint(x: 0.375*width, y: 0.91667*height))
        strokePath2.addLine(to: CGPoint(x: 0.625*width, y: 0.91667*height))
        strokePath2.addCurve(to: CGPoint(x: 0.91667*width, y: 0.625*height), control1: CGPoint(x: 0.83333*width, y: 0.91667*height), control2: CGPoint(x: 0.91667*width, y: 0.83333*height))
        strokePath2.addLine(to: CGPoint(x: 0.91667*width, y: 0.375*height))
        strokePath2.addCurve(to: CGPoint(x: 0.625*width, y: 0.08333*height), control1: CGPoint(x: 0.91667*width, y: 0.16667*height), control2: CGPoint(x: 0.83333*width, y: 0.08333*height))
        strokePath2.addLine(to: CGPoint(x: 0.375*width, y: 0.08333*height))
        strokePath2.addCurve(to: CGPoint(x: 0.08333*width, y: 0.375*height), control1: CGPoint(x: 0.16667*width, y: 0.08333*height), control2: CGPoint(x: 0.08333*width, y: 0.16667*height))
        strokePath2.addLine(to: CGPoint(x: 0.08333*width, y: 0.625*height))
        strokePath2.addCurve(to: CGPoint(x: 0.375*width, y: 0.91667*height), control1: CGPoint(x: 0.08333*width, y: 0.83333*height), control2: CGPoint(x: 0.16667*width, y: 0.91667*height))
        strokePath2.closeSubpath()
        path.addPath(strokePath2.strokedPath(StrokeStyle(lineWidth: 0.0625*width, lineCap: .round, lineJoin: .round, miterLimit: 4)))
        var strokePath4 = Path()
        strokePath4.move(to: CGPoint(x: 0.375*width, y: 0.41667*height))
        strokePath4.addCurve(to: CGPoint(x: 0.45833*width, y: 0.33333*height), control1: CGPoint(x: 0.42102*width, y: 0.41667*height), control2: CGPoint(x: 0.45833*width, y: 0.37936*height))
        strokePath4.addCurve(to: CGPoint(x: 0.375*width, y: 0.25*height), control1: CGPoint(x: 0.45833*width, y: 0.28731*height), control2: CGPoint(x: 0.42102*width, y: 0.25*height))
        strokePath4.addCurve(to: CGPoint(x: 0.29167*width, y: 0.33333*height), control1: CGPoint(x: 0.32898*width, y: 0.25*height), control2: CGPoint(x: 0.29167*width, y: 0.28731*height))
        strokePath4.addCurve(to: CGPoint(x: 0.375*width, y: 0.41667*height), control1: CGPoint(x: 0.29167*width, y: 0.37936*height), control2: CGPoint(x: 0.32898*width, y: 0.41667*height))
        strokePath4.closeSubpath()
        path.addPath(strokePath4.strokedPath(StrokeStyle(lineWidth: 0.0625*width, lineCap: .round, lineJoin: .round, miterLimit: 4)))
        var strokePath6 = Path()
        strokePath6.move(to: CGPoint(x: 0.11125*width, y: 0.78958*height))
        strokePath6.addLine(to: CGPoint(x: 0.31666*width, y: 0.65167*height))
        strokePath6.addCurve(to: CGPoint(x: 0.42666*width, y: 0.6575*height), control1: CGPoint(x: 0.34958*width, y: 0.62958*height), control2: CGPoint(x: 0.39708*width, y: 0.63208*height))
        strokePath6.addLine(to: CGPoint(x: 0.44041*width, y: 0.66958*height))
        strokePath6.addCurve(to: CGPoint(x: 0.55791*width, y: 0.66958*height), control1: CGPoint(x: 0.47291*width, y: 0.6975*height), control2: CGPoint(x: 0.52541*width, y: 0.6975*height))
        strokePath6.addLine(to: CGPoint(x: 0.73125*width, y: 0.52083*height))
        strokePath6.addCurve(to: CGPoint(x: 0.84875*width, y: 0.52083*height), control1: CGPoint(x: 0.76375*width, y: 0.49292*height), control2: CGPoint(x: 0.81625*width, y: 0.49292*height))
        strokePath6.addLine(to: CGPoint(x: 0.91666*width, y: 0.57917*height))
        path.addPath(strokePath6.strokedPath(StrokeStyle(lineWidth: 0.0625*width, lineCap: .round, lineJoin: .round, miterLimit: 4)))
        return path
    }
}

#Preview {
    GalleryIcon()
        .fill(AppGradient.main)
        .frame(width: 32, height: 32)
}
