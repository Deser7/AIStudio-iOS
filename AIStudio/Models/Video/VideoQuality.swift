//
//  VideoQuality.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import Foundation

enum VideoQuality: String, CaseIterable, Identifiable, Hashable, Sendable {
    case p540 = "540p"
    case p720 = "720p"
    case p1080 = "1080p"
    case k4 = "4K"

    var id: String { rawValue }
    var title: String { rawValue }
}
