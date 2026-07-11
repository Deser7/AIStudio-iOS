//
//  ChatHistoryRepository.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 11.07.2026.
//

import Foundation
import SwiftData

@MainActor
final class ChatHistoryRepository {
    private let modelContext: ModelContext

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    private static let sectionDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func session(id: UUID) -> (title: String, updatedAt: Date, messages: [ChatMessage])? {
        guard let entity = fetchEntity(id: id) else { return nil }
        return (
            entity.title,
            entity.updatedAt,
            ChatMessagePersistenceMapper.decode(entity.messagesData)
        )
    }

    func upsert(id: UUID, fallbackTitle: String, messages: [ChatMessage]) {
        let data = ChatMessagePersistenceMapper.encode(messages)
        guard !data.isEmpty else { return }

        if let entity = fetchEntity(id: id) {
            entity.updatedAt = .now
            entity.messagesData = data
        } else {
            modelContext.insert(
                ChatSessionEntity(
                    id: id,
                    title: fallbackTitle,
                    updatedAt: .now,
                    messagesData: data
                )
            )
        }

        save()
    }

    func rename(id: UUID, title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, let entity = fetchEntity(id: id) else { return }
        entity.title = trimmed
        entity.updatedAt = .now
        save()
    }

    func delete(id: UUID) {
        guard let entity = fetchEntity(id: id) else { return }
        modelContext.delete(entity)
        save()
    }

    func makeSections() -> [ChatHistorySection] {
        let descriptor = FetchDescriptor<ChatSessionEntity>(
            sortBy: [SortDescriptor(\.updatedAt, order: .reverse)]
        )
        let sessions = (try? modelContext.fetch(descriptor)) ?? []

        let calendar = Calendar.current
        var grouped: [(key: Date, title: String, items: [ChatHistoryItem])] = []

        for session in sessions {
            let day = calendar.startOfDay(for: session.updatedAt)
            let sectionTitle = Self.sectionTitle(for: session.updatedAt, calendar: calendar)
            let item = ChatHistoryItem(
                id: session.id,
                title: session.title,
                time: Self.timeFormatter.string(from: session.updatedAt)
            )

            if let index = grouped.firstIndex(where: { $0.key == day }) {
                grouped[index].items.append(item)
            } else {
                grouped.append((day, sectionTitle, [item]))
            }
        }

        return grouped.map { entry in
            ChatHistorySection(
                id: "\(entry.key.timeIntervalSince1970)",
                title: entry.title,
                items: entry.items
            )
        }
    }

    private func fetchEntity(id: UUID) -> ChatSessionEntity? {
        let targetID = id
        let descriptor = FetchDescriptor<ChatSessionEntity>(
            predicate: #Predicate<ChatSessionEntity> { session in
                session.id == targetID
            }
        )
        if let entity = try? modelContext.fetch(descriptor).first {
            return entity
        }

        let all = (try? modelContext.fetch(FetchDescriptor<ChatSessionEntity>())) ?? []
        return all.first { $0.id == targetID }
    }

    private func save() {
        guard modelContext.hasChanges else { return }
        try? modelContext.save()
    }

    private static func sectionTitle(for date: Date, calendar: Calendar) -> String {
        if calendar.isDateInToday(date) {
            return "Today"
        }
        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }
        return sectionDateFormatter.string(from: date)
    }
}
