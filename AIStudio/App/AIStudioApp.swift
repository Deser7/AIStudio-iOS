//
//  AIStudioApp.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 19.06.2026.
//

import SwiftData
import SwiftUI

@main
struct AIStudioApp: App {
    private let modelContainer: ModelContainer = {
        let schema = Schema([ChatSessionEntity.self])
        let configuration = ModelConfiguration("ChatHistory", schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            // Schema changed during development — reset local store once.
            let url = configuration.url
            try? FileManager.default.removeItem(at: url)
            return try! ModelContainer(for: schema, configurations: [configuration])
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(modelContainer)
    }
}
