//
//  VideoTemplate.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation

struct VideoTemplate: Identifiable, Hashable, Sendable {
    let id: UUID
    let title: String

    nonisolated init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}

struct VideoTemplateSection: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let templates: [VideoTemplate]

    nonisolated init(id: String, name: String, templates: [VideoTemplate]) {
        self.id = id
        self.name = name
        self.templates = templates
    }
}

enum VideoTemplateStub: Sendable {
    nonisolated static let sections: [VideoTemplateSection] = [
        section(id: "popular", name: "Popular", count: 6),
        section(id: "funny", name: "Funny", count: 4),
        section(id: "sad", name: "Sad", count: 4),
        section(id: "trends", name: "Trends", count: 6),
        section(id: "dances", name: "Dances", count: 4)
    ]

    nonisolated private static func section(id: String, name: String, count: Int) -> VideoTemplateSection {
        VideoTemplateSection(
            id: id,
            name: name,
            templates: (0..<count).map { _ in
                VideoTemplate(title: "Title")
            }
        )
    }
}
