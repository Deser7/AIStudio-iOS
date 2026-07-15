//
//  ChatServing.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

protocol ChatServing: Sendable {
    func streamMessage(
        chatID: String,
        history: [ChatHistoryMessage],
        systemInstruction: String?
    ) -> AsyncThrowingStream<String, Error>
}
