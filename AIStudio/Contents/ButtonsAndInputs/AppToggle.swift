//
//  AppToggle.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

/// Toggle (Figma ref 51×31).
struct AppToggle: View {
    @Binding var isOn: Bool

    private var thumbOffsetX: CGFloat {
        isOn ? 22 : 2
    }

    private var trackFill: Color {
        isOn ? .white : .toggleTrackSecondary
    }

    private var thumbFill: Color {
        isOn ? .surface : .white
    }

    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.25, bounce: 0.2)) {
                isOn.toggle()
            }
        } label: {
            ZStack(alignment: .leading) {
                track

                thumb
                    .offset(x: thumbOffsetX)
            }
            .frame(width: 51, height: 31)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isOn ? .isSelected : [])
        .accessibilityValue(isOn ? Text("On") : Text("Off"))
    }

    private var track: some View {
        Capsule()
            .fill(trackFill)
            .frame(width: 51, height: 31)
    }

    private var thumb: some View {
        Circle()
            .fill(thumbFill)
            .frame(width: 27, height: 27)
            .shadow(color: .black.opacity(0.06), radius: 0.5, x: 0, y: 3)
            .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 3)
    }
}

struct AppToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        AppToggle(isOn: configuration.$isOn)
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
