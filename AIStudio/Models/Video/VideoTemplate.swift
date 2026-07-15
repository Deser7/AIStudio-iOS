//
//  VideoTemplate.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation

struct VideoTemplate: Identifiable, Hashable, Sendable {
    let id: UUID = UUID()
    let title: String
}
