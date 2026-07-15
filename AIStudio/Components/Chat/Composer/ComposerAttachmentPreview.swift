//
//  ComposerAttachmentPreview.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 29.06.2026.
//

import SwiftUI

struct ComposerAttachmentPreview: Identifiable, Equatable {
    let id: UUID
    let image: Image

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
