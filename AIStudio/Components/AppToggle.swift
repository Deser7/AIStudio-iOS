//
//  AppToggle.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct AppToggle: View {
    private enum Layout {
        static let width: CGFloat = 51
        static let height: CGFloat = 31
        static let thumbSize: CGFloat = 27
        static let thumbInset: CGFloat = 2
        static let thumbOffsetOn: CGFloat = 22
    }

    @Binding var isOn: Bool

    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.25, bounce: 0.2)) {
                isOn.toggle()
            }
        } label: {
            ZStack(alignment: .leading) {
                track

                thumb
                    .offset(x: isOn ? Layout.thumbOffsetOn : Layout.thumbInset)
            }
            .frame(width: Layout.width, height: Layout.height)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isOn ? .isSelected : [])
        .accessibilityValue(isOn ? Text("On") : Text("Off"))
    }

    private var track: some View {
        Capsule()
            .fill(isOn ? Color.accent : Color.toggleTrackSecondary)
            .frame(width: Layout.width, height: Layout.height)
    }

    private var thumb: some View {
        Circle()
            .fill(isOn ? Color.toggleThumb : Color.accent)
            .frame(width: Layout.thumbSize, height: Layout.thumbSize)
            .shadow(color: .black.opacity(0.06), radius: 0.5, x: 0, y: 3)
            .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 3)
    }
}

struct AppToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        AppToggle(isOn: configuration.$isOn)
    }
}

#Preview("Toggle") {
    struct PreviewContainer: View {
        @State private var isOnTop = true
        @State private var isOnBottom = false

        var body: some View {
            VStack(spacing: 24) {
                AppToggle(isOn: $isOnTop)
                AppToggle(isOn: $isOnBottom)
            }
            .padding(24)
            .background(Color.background)
        }
    }

    return PreviewContainer()
}

#Preview("ToggleStyle") {
    struct PreviewContainer: View {
        @State private var isOn = true

        var body: some View {
            Toggle("Label", isOn: $isOn)
                .toggleStyle(AppToggleStyle())
                .padding(24)
        }
    }

    return PreviewContainer()
}
