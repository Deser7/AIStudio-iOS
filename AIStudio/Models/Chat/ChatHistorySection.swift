//
//  ChatHistorySection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation

struct ChatHistorySection: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let items: [ChatHistoryItem]
}
