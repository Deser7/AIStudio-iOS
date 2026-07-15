//
//  FunctionCardOption.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 27.06.2026.
//

import Foundation

enum FunctionCardOption: Sendable {
    case fixWriting
    case understandFaster

    var title: String {
        switch self {
        case .fixWriting: "Fix & Improve\nWriting"
        case .understandFaster: "Understand\nFaster"
        }
    }

    var subtitle: String {
        switch self {
        case .fixWriting: "Rewrite • Fix grammar"
        case .understandFaster: "Summarize • Key points"
        }
    }
}
