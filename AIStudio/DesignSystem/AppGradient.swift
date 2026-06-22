//
//  AppGradient.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AppGradient {
    /// Figma «main»: #98C6F7 → #EB5B92, горизонтально.
    static let main = LinearGradient(
        colors: [.aiBlue, .aiPink],
        startPoint: .leading,
        endPoint: .trailing
    )
}
