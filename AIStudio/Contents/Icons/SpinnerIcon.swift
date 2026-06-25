//
//  SpinnerIcon.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct SpinnerIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: 0.5 * width, y: 0.03125 * height))
        path.addCurve(to: CGPoint(x: 0.4375 * width, y: 0.09375 * height), control1: CGPoint(x: 0.46548 * width, y: 0.03125 * height), control2: CGPoint(x: 0.4375 * width, y: 0.05923 * height))
        path.addLine(to: CGPoint(x: 0.4375 * width, y: 0.28125 * height))
        path.addCurve(to: CGPoint(x: 0.5 * width, y: 0.34375 * height), control1: CGPoint(x: 0.4375 * width, y: 0.31577 * height), control2: CGPoint(x: 0.46548 * width, y: 0.34375 * height))
        path.addCurve(to: CGPoint(x: 0.5625 * width, y: 0.28125 * height), control1: CGPoint(x: 0.53452 * width, y: 0.34375 * height), control2: CGPoint(x: 0.5625 * width, y: 0.31577 * height))
        path.addLine(to: CGPoint(x: 0.5625 * width, y: 0.09375 * height))
        path.addCurve(to: CGPoint(x: 0.5 * width, y: 0.03125 * height), control1: CGPoint(x: 0.5625 * width, y: 0.05923 * height), control2: CGPoint(x: 0.53452 * width, y: 0.03125 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.83146 * width, y: 0.16854 * height))
        path.addCurve(to: CGPoint(x: 0.74307 * width, y: 0.16854 * height), control1: CGPoint(x: 0.80705 * width, y: 0.14414 * height), control2: CGPoint(x: 0.76748 * width, y: 0.14414 * height))
        path.addLine(to: CGPoint(x: 0.61048 * width, y: 0.30113 * height))
        path.addCurve(to: CGPoint(x: 0.61048 * width, y: 0.38952 * height), control1: CGPoint(x: 0.58608 * width, y: 0.32553 * height), control2: CGPoint(x: 0.58608 * width, y: 0.36511 * height))
        path.addCurve(to: CGPoint(x: 0.69888 * width, y: 0.38952 * height), control1: CGPoint(x: 0.63489 * width, y: 0.41392 * height), control2: CGPoint(x: 0.67447 * width, y: 0.41392 * height))
        path.addLine(to: CGPoint(x: 0.83146 * width, y: 0.25693 * height))
        path.addCurve(to: CGPoint(x: 0.83146 * width, y: 0.16854 * height), control1: CGPoint(x: 0.85586 * width, y: 0.23252 * height), control2: CGPoint(x: 0.85586 * width, y: 0.19295 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.90625 * width, y: 0.4375 * height))
        path.addCurve(to: CGPoint(x: 0.96875 * width, y: 0.5 * height), control1: CGPoint(x: 0.94077 * width, y: 0.4375 * height), control2: CGPoint(x: 0.96875 * width, y: 0.46548 * height))
        path.addCurve(to: CGPoint(x: 0.90625 * width, y: 0.5625 * height), control1: CGPoint(x: 0.96875 * width, y: 0.53452 * height), control2: CGPoint(x: 0.94077 * width, y: 0.5625 * height))
        path.addLine(to: CGPoint(x: 0.71875 * width, y: 0.5625 * height))
        path.addCurve(to: CGPoint(x: 0.65625 * width, y: 0.5 * height), control1: CGPoint(x: 0.68423 * width, y: 0.5625 * height), control2: CGPoint(x: 0.65625 * width, y: 0.53452 * height))
        path.addCurve(to: CGPoint(x: 0.71875 * width, y: 0.4375 * height), control1: CGPoint(x: 0.65625 * width, y: 0.46548 * height), control2: CGPoint(x: 0.68423 * width, y: 0.4375 * height))
        path.addLine(to: CGPoint(x: 0.90625 * width, y: 0.4375 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.83146 * width, y: 0.83146 * height))
        path.addCurve(to: CGPoint(x: 0.83146 * width, y: 0.74307 * height), control1: CGPoint(x: 0.85586 * width, y: 0.80705 * height), control2: CGPoint(x: 0.85586 * width, y: 0.76748 * height))
        path.addLine(to: CGPoint(x: 0.69888 * width, y: 0.61048 * height))
        path.addCurve(to: CGPoint(x: 0.61048 * width, y: 0.61048 * height), control1: CGPoint(x: 0.67447 * width, y: 0.58608 * height), control2: CGPoint(x: 0.63489 * width, y: 0.58608 * height))
        path.addCurve(to: CGPoint(x: 0.61048 * width, y: 0.69888 * height), control1: CGPoint(x: 0.58608 * width, y: 0.63489 * height), control2: CGPoint(x: 0.58608 * width, y: 0.67447 * height))
        path.addLine(to: CGPoint(x: 0.74307 * width, y: 0.83146 * height))
        path.addCurve(to: CGPoint(x: 0.83146 * width, y: 0.83146 * height), control1: CGPoint(x: 0.76748 * width, y: 0.85586 * height), control2: CGPoint(x: 0.80705 * width, y: 0.85586 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.4375 * width, y: 0.71875 * height))
        path.addCurve(to: CGPoint(x: 0.5 * width, y: 0.65625 * height), control1: CGPoint(x: 0.4375 * width, y: 0.68423 * height), control2: CGPoint(x: 0.46548 * width, y: 0.65625 * height))
        path.addCurve(to: CGPoint(x: 0.5625 * width, y: 0.71875 * height), control1: CGPoint(x: 0.53452 * width, y: 0.65625 * height), control2: CGPoint(x: 0.5625 * width, y: 0.68423 * height))
        path.addLine(to: CGPoint(x: 0.5625 * width, y: 0.90625 * height))
        path.addCurve(to: CGPoint(x: 0.5 * width, y: 0.96875 * height), control1: CGPoint(x: 0.5625 * width, y: 0.94077 * height), control2: CGPoint(x: 0.53452 * width, y: 0.96875 * height))
        path.addCurve(to: CGPoint(x: 0.4375 * width, y: 0.90625 * height), control1: CGPoint(x: 0.46548 * width, y: 0.96875 * height), control2: CGPoint(x: 0.4375 * width, y: 0.94077 * height))
        path.addLine(to: CGPoint(x: 0.4375 * width, y: 0.71875 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.38952 * width, y: 0.61049 * height))
        path.addCurve(to: CGPoint(x: 0.30113 * width, y: 0.61049 * height), control1: CGPoint(x: 0.36511 * width, y: 0.58608 * height), control2: CGPoint(x: 0.32553 * width, y: 0.58608 * height))
        path.addLine(to: CGPoint(x: 0.16854 * width, y: 0.74307 * height))
        path.addCurve(to: CGPoint(x: 0.16854 * width, y: 0.83146 * height), control1: CGPoint(x: 0.14414 * width, y: 0.76748 * height), control2: CGPoint(x: 0.14414 * width, y: 0.80705 * height))
        path.addCurve(to: CGPoint(x: 0.25693 * width, y: 0.83146 * height), control1: CGPoint(x: 0.19295 * width, y: 0.85587 * height), control2: CGPoint(x: 0.23252 * width, y: 0.85587 * height))
        path.addLine(to: CGPoint(x: 0.38952 * width, y: 0.69888 * height))
        path.addCurve(to: CGPoint(x: 0.38952 * width, y: 0.61049 * height), control1: CGPoint(x: 0.41392 * width, y: 0.67447 * height), control2: CGPoint(x: 0.41392 * width, y: 0.63489 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.28125 * width, y: 0.4375 * height))
        path.addCurve(to: CGPoint(x: 0.34375 * width, y: 0.5 * height), control1: CGPoint(x: 0.31577 * width, y: 0.4375 * height), control2: CGPoint(x: 0.34375 * width, y: 0.46548 * height))
        path.addCurve(to: CGPoint(x: 0.28125 * width, y: 0.5625 * height), control1: CGPoint(x: 0.34375 * width, y: 0.53452 * height), control2: CGPoint(x: 0.31577 * width, y: 0.5625 * height))
        path.addLine(to: CGPoint(x: 0.09375 * width, y: 0.5625 * height))
        path.addCurve(to: CGPoint(x: 0.03125 * width, y: 0.5 * height), control1: CGPoint(x: 0.05923 * width, y: 0.5625 * height), control2: CGPoint(x: 0.03125 * width, y: 0.53452 * height))
        path.addCurve(to: CGPoint(x: 0.09375 * width, y: 0.4375 * height), control1: CGPoint(x: 0.03125 * width, y: 0.46548 * height), control2: CGPoint(x: 0.05923 * width, y: 0.4375 * height))
        path.addLine(to: CGPoint(x: 0.28125 * width, y: 0.4375 * height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.38952 * width, y: 0.38951 * height))
        path.addCurve(to: CGPoint(x: 0.38952 * width, y: 0.30113 * height), control1: CGPoint(x: 0.41392 * width, y: 0.36511 * height), control2: CGPoint(x: 0.41392 * width, y: 0.32553 * height))
        path.addLine(to: CGPoint(x: 0.25693 * width, y: 0.16854 * height))
        path.addCurve(to: CGPoint(x: 0.16854 * width, y: 0.16854 * height), control1: CGPoint(x: 0.23252 * width, y: 0.14414 * height), control2: CGPoint(x: 0.19295 * width, y: 0.14414 * height))
        path.addCurve(to: CGPoint(x: 0.16854 * width, y: 0.25693 * height), control1: CGPoint(x: 0.14414 * width, y: 0.19295 * height), control2: CGPoint(x: 0.14414 * width, y: 0.23252 * height))
        path.addLine(to: CGPoint(x: 0.30113 * width, y: 0.38951 * height))
        path.addCurve(to: CGPoint(x: 0.38952 * width, y: 0.38951 * height), control1: CGPoint(x: 0.32553 * width, y: 0.41392 * height), control2: CGPoint(x: 0.36511 * width, y: 0.41392 * height))
        path.closeSubpath()

        return path
    }
}

#Preview {
    SpinnerIcon()
        .fill(.black)
        .frame(width: 48, height: 48)
        .padding(24)
        .background(Color.background)
}
