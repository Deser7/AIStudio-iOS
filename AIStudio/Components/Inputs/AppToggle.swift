//
//  AppToggle.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct AppToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.25, bounce: 0.2)) {
                isOn.toggle()
            }
        } label: {
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(isOn ? .white : .toggleTrackSecondary)

                Circle()
                    .fill(isOn ? .surface : .white)
                    .frame(width: 27, height: 27)
                    .shadow(color: .black.opacity(0.06), radius: 0.5, x: 0, y: 3)
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 3)
                    .offset(x: isOn ? 20 : 2)
            }
            .frame(width: 51, height: 31)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isOn ? .isSelected : [])
        .accessibilityValue(Text(isOn ? "On" : "Off"))
    }
}

#Preview {
    AppTogglePreview()
}

private struct AppTogglePreview: View {
    @State private var isOn = true
    @State private var isToggleStyleOn = false

    var body: some View {
        VStack(spacing: 24) {
            AppToggle(isOn: $isOn)

            Toggle("Label", isOn: $isToggleStyleOn)
                .toggleStyle(AppToggleStyle())
        }
        .padding(24)
        .background(Color.background)
    }
}
