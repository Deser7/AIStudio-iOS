//
//  ChatHistoryPreviewSupport.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 11.07.2026.
//

import Foundation
import SwiftData

enum ChatHistoryPreviewSupport {
    @MainActor
    static func container(seedSample: Bool = false) -> ModelContainer {
        let schema = Schema([ChatSessionEntity.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])

        if seedSample {
            let repository = ChatHistoryRepository(modelContext: container.mainContext)
            repository.upsert(
                id: UUID(),
                fallbackTitle: "Hello, this is a test recording....",
                messages: [
                    .user(text: "Hello, this is a test recording...."),
                    .assistant(
                        content: AIResponseContent(
                            title: "",
                            paragraphs: ["Preview assistant reply"],
                            bullets: []
                        )
                    )
                ]
            )
        }

        return container
    }
}
