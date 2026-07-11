//
//  ChatHistoryViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class ChatHistoryViewModel {
    let title = "AI Chat History"

    private(set) var sections: [ChatHistorySection] = []

    var isEmpty: Bool {
        sections.allSatisfy(\.items.isEmpty)
    }

    private let repository: ChatHistoryRepository

    init(repository: ChatHistoryRepository) {
        self.repository = repository
        reload()
    }

    func reload() {
        sections = repository.makeSections()
    }

    func delete(_ item: ChatHistoryItem) {
        repository.delete(id: item.id)
        reload()
    }

    func rename(_ item: ChatHistoryItem, to title: String) {
        repository.rename(id: item.id, title: title)
        reload()
    }
}
