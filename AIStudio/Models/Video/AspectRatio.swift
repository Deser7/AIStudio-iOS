//
//  AspectRatio.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import Foundation

enum AspectRatio: CaseIterable, Hashable, Sendable {
    case landscape16x9
    case portrait9x16
    case square1x1

    var title: String {
        switch self {
        case .landscape16x9: "16:9"
        case .portrait9x16: "9:16"
        case .square1x1: "1:1"
        }
    }
}
