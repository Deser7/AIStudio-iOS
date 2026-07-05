//
//  ChatMessage.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import Foundation

enum ChatMessage: Identifiable, Hashable, Sendable {
    case user(id: UUID = UUID(), text: String)
    case generating(id: UUID = UUID())
    case assistant(id: UUID = UUID(), content: AIResponseContent)

    var id: UUID {
        switch self {
        case let .user(id, _),
             let .generating(id),
             let .assistant(id, _):
            id
        }
    }
}

enum ChatStub {
    static let welcomeEmail = AIResponseContent(
        title: "Welcome to the team, Alexander!",
        paragraphs: [
            """
            Hi Alexander, welcome to the development team! We're all really \
            looking forward to having you start next week, and we're confident \
            you'll settle in quickly.
            """,
            "Here are a few tips to help you get through your first week:"
        ],
        bullets: [
            AIResponseBullet(
                emphasis: "Focus on getting up to speed",
                text: """
                don't hesitate to ask questions if anything is unclear. We're used \
                to helping new team members find their feet.
                """
            ),
            AIResponseBullet(
                emphasis: "Meet the team",
                text: """
                we're having a short welcome meeting on Monday at 11:00 AM. It'll \
                be a great chance to connect with everyone.
                """
            ),
            AIResponseBullet(
                emphasis: "Documentation",
                text: """
                all the key materials are available in our internal knowledge base. \
                I'll send you the link separately.
                """
            )
        ],
        closingParagraphs: [
            """
            If you need help setting up your development environment or have any \
            questions about the projects, feel free to reach out to me or the tech lead.
            """,
            "Looking forward to working with you!",
            "Best,",
            "[Your Name]",
            "Team Lead"
        ]
    )
}
