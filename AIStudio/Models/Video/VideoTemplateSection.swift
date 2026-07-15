//
//  VideoTemplateSection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation

struct VideoTemplateSection: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let templates: [VideoTemplate]
}
