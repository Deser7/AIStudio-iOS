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
                fallbackTitle: "Marketing for “FitApp”",
                messages: [
                    .user(text: "Marketing for “FitApp”"),
                    .assistant(
                        content: AIResponseContent(
                            title: "",
                            paragraphs: ["Ideas for launch, positioning, and pricing"],
                            bullets: []
                        )
                    )
                ],
                direction: .marketer
            )
        }

        return container
    }
}
