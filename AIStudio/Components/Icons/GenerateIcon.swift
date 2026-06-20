//
//  VectorIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct GenerateIcon: View {
    let color: Color
    
    var body: some View {
        Canvas { context, size in
            let scaleX = size.width / 19
            let scaleY = size.height / 19
            
            context.scaleBy(x: scaleX, y: scaleY)
            
            var path1 = Path()
            path1.move(to: CGPoint(x: 5.43949, y: 0.834083))
            path1.addCurve(to: CGPoint(x: 7.56051, y: 0.834082),
                           control1: CGPoint(x: 5.70916, y: -0.278027),
                           control2: CGPoint(x: 7.29084, y: -0.278028))
            path1.addLine(to: CGPoint(x: 8.30252, y: 3.89413))
            path1.addCurve(to: CGPoint(x: 9.10587, y: 4.69748),
                           control1: CGPoint(x: 8.3988, y: 4.29118),
                           control2: CGPoint(x: 8.70882, y: 4.6012))
            path1.addLine(to: CGPoint(x: 12.1659, y: 5.43949))
            path1.addCurve(to: CGPoint(x: 12.1659, y: 7.56051),
                           control1: CGPoint(x: 13.278, y: 5.70916),
                           control2: CGPoint(x: 13.278, y: 7.29084))
            path1.addLine(to: CGPoint(x: 9.10587, y: 8.30252))
            path1.addCurve(to: CGPoint(x: 8.30252, y: 9.10587),
                           control1: CGPoint(x: 8.70882, y: 8.3988),
                           control2: CGPoint(x: 8.3988, y: 8.70882))
            path1.addLine(to: CGPoint(x: 7.56051, y: 12.1659))
            path1.addCurve(to: CGPoint(x: 5.43949, y: 12.1659),
                           control1: CGPoint(x: 7.29084, y: 13.278),
                           control2: CGPoint(x: 5.70916, y: 13.278))
            path1.addLine(to: CGPoint(x: 4.69748, y: 9.10587))
            path1.addCurve(to: CGPoint(x: 3.89413, y: 8.30252),
                           control1: CGPoint(x: 4.6012, y: 8.70882),
                           control2: CGPoint(x: 4.29118, y: 8.3988))
            path1.addLine(to: CGPoint(x: 0.834083, y: 7.56051))
            path1.addCurve(to: CGPoint(x: 0.834082, y: 5.43949),
                           control1: CGPoint(x: -0.278027, y: 7.29084),
                           control2: CGPoint(x: -0.278028, y: 5.70916))
            path1.addLine(to: CGPoint(x: 3.89413, y: 4.69748))
            path1.addCurve(to: CGPoint(x: 4.69748, y: 3.89413),
                           control1: CGPoint(x: 4.29118, y: 4.6012),
                           control2: CGPoint(x: 4.6012, y: 4.29118))
            path1.closeSubpath()
            
            var path2 = Path()
            path2.move(to: CGPoint(x: 14.3474, y: 11.5133))
            path2.addCurve(to: CGPoint(x: 15.6526, y: 11.5133),
                           control1: CGPoint(x: 14.5133, y: 10.8289),
                           control2: CGPoint(x: 15.4867, y: 10.8289))
            path2.addLine(to: CGPoint(x: 16.1092, y: 13.3964))
            path2.addCurve(to: CGPoint(x: 16.6036, y: 13.8908),
                           control1: CGPoint(x: 16.1685, y: 13.6407),
                           control2: CGPoint(x: 16.3593, y: 13.8315))
            path2.addLine(to: CGPoint(x: 18.4867, y: 14.3474))
            path2.addCurve(to: CGPoint(x: 18.4867, y: 15.6526),
                           control1: CGPoint(x: 19.1711, y: 14.5133),
                           control2: CGPoint(x: 19.1711, y: 15.4867))
            path2.addLine(to: CGPoint(x: 16.6036, y: 16.1092))
            path2.addCurve(to: CGPoint(x: 16.1092, y: 16.6036),
                           control1: CGPoint(x: 16.3593, y: 16.1685),
                           control2: CGPoint(x: 16.1685, y: 16.3593))
            path2.addLine(to: CGPoint(x: 15.6526, y: 18.4867))
            path2.addCurve(to: CGPoint(x: 14.3474, y: 18.4867),
                           control1: CGPoint(x: 15.4867, y: 19.1711),
                           control2: CGPoint(x: 14.5133, y: 19.1711))
            path2.addLine(to: CGPoint(x: 13.8908, y: 16.6036))
            path2.addCurve(to: CGPoint(x: 13.3964, y: 16.1092),
                           control1: CGPoint(x: 13.8315, y: 16.3593),
                           control2: CGPoint(x: 13.6407, y: 16.1685))
            path2.addLine(to: CGPoint(x: 11.5133, y: 15.6526))
            path2.addCurve(to: CGPoint(x: 11.5133, y: 14.3474),
                           control1: CGPoint(x: 10.8289, y: 15.4867),
                           control2: CGPoint(x: 10.8289, y: 14.5133))
            path2.addLine(to: CGPoint(x: 13.3964, y: 13.8908))
            path2.addCurve(to: CGPoint(x: 13.8908, y: 13.3964),
                           control1: CGPoint(x: 13.6407, y: 13.8315),
                           control2: CGPoint(x: 13.8315, y: 13.6407))
            path2.closeSubpath()
            
            context.fill(path1, with: .color(color))
            context.fill(path2, with: .color(color))
        }
    }
}

#Preview {
    GenerateIcon(color: .black)
        .frame(width: 100, height: 100)
}
