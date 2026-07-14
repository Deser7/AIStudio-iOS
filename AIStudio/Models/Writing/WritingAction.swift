//
//  WritingAction.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 13.07.2026.
//

import Foundation

enum WritingAction: String, CaseIterable, Identifiable, Sendable {
    case improve = "Improve"
    case rewrite = "Rewrite"
    case fixGrammar = "Fix grammar"
    case shorten = "Shorten"

    var id: String { rawValue }
    var title: String { rawValue }
}
