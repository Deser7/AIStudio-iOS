//
//  AppToggleStyle.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct AppToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        AppToggle(isOn: configuration.$isOn)
    }
}

#Preview {
    AppToggleStylePreview()
}

private struct AppToggleStylePreview: View {
    @State private var isOn = true

    var body: some View {
        Toggle("Label", isOn: $isOn)
            .toggleStyle(AppToggleStyle())
            .padding(24)
            .background(Color.background)
    }
}
