//
//  View+Disabled.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import SwiftUI

extension View {
    func appDisabledOpacity() -> some View {
        modifier(AppDisabledOpacityModifier())
    }
}

private struct AppDisabledOpacityModifier: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        content.opacity(isEnabled ? 1 : 0.6)
    }
}
