//
//  EqualizerIconLayout.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import CoreGraphics

enum EqualizerIconLayout {
    /// Группы по 9 палочек слева направо; сегмент 4 — хвост из 3 палочек.
    static let groupLeadingEdge: [CGFloat] = [0, 0.23404, 0.46853, 0.70343, 0.93501]
    static let groupTrailingEdge: [CGFloat] = [0.22135, 0.45564, 0.69084, 0.92241, 0.99796]

    static func segmentStart(at index: Int) -> CGFloat {
        groupLeadingEdge[index]
    }

    static func segmentEnd(at index: Int) -> CGFloat {
        groupTrailingEdge[index]
    }
}
