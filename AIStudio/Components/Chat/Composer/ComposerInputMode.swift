//
//  ComposerInputMode.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 29.06.2026.
//

import CoreGraphics

enum ComposerInputMode: Equatable {
    case text
    case recording(progress: CGFloat)
    case attachment(isLoading: Bool)
}
