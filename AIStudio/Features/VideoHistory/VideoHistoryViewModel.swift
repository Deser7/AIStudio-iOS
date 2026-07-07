//
//  VideoHistoryViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 07.07.2026.
//

import Observation

@Observable
final class VideoHistoryViewModel {
    let title = "AI Video History"

    private(set) var items: [VideoHistoryItem]

    var isEmpty: Bool {
        items.isEmpty
    }

    init(items: [VideoHistoryItem] = VideoHistoryStub.items) {
        self.items = items
    }

    func itemTapped(_ item: VideoHistoryItem) {}
}
