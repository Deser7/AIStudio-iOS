//
//  AppToggle.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct AppToggle: View {
    static let defaultSize: CGFloat = 31

    private enum Layout {
        static let aspectRatio: CGFloat = 51 / 31
        static let thumbSizeRatio: CGFloat = 27 / 31
        static let thumbInsetRatio: CGFloat = 2 / 31
        static let thumbOffsetOnRatio: CGFloat = 22 / 31
        static let shadowYOffsetRatio: CGFloat = 3 / 31
        static let shadowBlurSmallRatio: CGFloat = 0.5 / 31
        static let shadowBlurLargeRatio: CGFloat = 4 / 31
    }

    var size: CGFloat = AppToggle.defaultSize
    @Binding var isOn: Bool

    private var width: CGFloat { size * Layout.aspectRatio }
    private var thumbSize: CGFloat { size * Layout.thumbSizeRatio }
    private var thumbInset: CGFloat { size * Layout.thumbInsetRatio }
    private var thumbOffsetOn: CGFloat { size * Layout.thumbOffsetOnRatio }

    var body: some View {
        Button {
            withAnimation(.spring(duration: 0.25, bounce: 0.2)) {
                isOn.toggle()
            }
        } label: {
            ZStack(alignment: .leading) {
                track

                thumb
                    .offset(x: isOn ? thumbOffsetOn : thumbInset)
            }
            .frame(width: width, height: size)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isOn ? .isSelected : [])
        .accessibilityValue(isOn ? Text("On") : Text("Off"))
    }

    private var track: some View {
        Capsule()
            .fill(isOn ? Color.accent : Color.toggleTrackSecondary)
            .frame(width: width, height: size)
    }

    private var thumb: some View {
        Circle()
            .fill(isOn ? Color.toggleThumb : Color.accent)
            .frame(width: thumbSize, height: thumbSize)
            .shadow(
                color: .black.opacity(0.06),
                radius: size * Layout.shadowBlurSmallRatio,
                x: 0,
                y: size * Layout.shadowYOffsetRatio
            )
            .shadow(
                color: .black.opacity(0.15),
                radius: size * Layout.shadowBlurLargeRatio,
                x: 0,
                y: size * Layout.shadowYOffsetRatio
            )
    }
}

struct AppToggleStyle: ToggleStyle {
    var size: CGFloat = AppToggle.defaultSize

    func makeBody(configuration: Configuration) -> some View {
        AppToggle(size: size, isOn: configuration.$isOn)
    }
}

#Preview("Toggle") {
    struct PreviewContainer: View {
        @State private var isOnTop = true
        @State private var isOnBottom = false

        var body: some View {
            VStack(spacing: 24) {
                AppToggle(size: 31, isOn: $isOnTop)
                AppToggle(size: 40, isOn: $isOnBottom)
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
                .toggleStyle(AppToggleStyle(size: 31))
                .padding(24)
                .background(Color.background)
        }
    }

    return PreviewContainer()
}
