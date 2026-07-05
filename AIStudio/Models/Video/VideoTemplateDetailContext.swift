//
//  VideoTemplateDetailContext.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation

struct VideoTemplateDetailContext: Hashable, Sendable {
    let selectedTemplate: VideoTemplate
    let sectionTemplates: [VideoTemplate]
}
