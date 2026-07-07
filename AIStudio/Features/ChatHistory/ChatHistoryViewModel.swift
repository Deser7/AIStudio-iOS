//
//  ChatHistoryViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Observation

@Observable
final class ChatHistoryViewModel {
    let title = "AI Chat History"

    private(set) var sections: [ChatHistorySection]

    var isEmpty: Bool {
        sections.allSatisfy(\.items.isEmpty)
    }

    init(sections: [ChatHistorySection] = ChatHistoryStub.sections) {
        self.sections = sections
    }

    func itemTapped(_ item: ChatHistoryItem) {}
}
