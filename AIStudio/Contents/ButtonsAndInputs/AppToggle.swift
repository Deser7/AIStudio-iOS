//
//  AppToggle.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct AppToggle: View {
    var height: CGFloat
    @Binding var isOn: Bool

    private var width: CGFloat { height * 51 / 31 }
    private var thumbSize: CGFloat { height * 27 / 31 }
    private var thumbInset: CGFloat { height * 2 / 31 }
    private var thumbOffsetOn: CGFloat { height * 22 / 31 }
    private var thumbShadowYOffset: CGFloat { height * 3 / 31 }
    private var thumbShadowRadiusSoft: CGFloat { height * 1 / 62 }
    private var thumbShadowRadiusHard: CGFloat { height * 4 / 31 }

    private var thumbOffsetX: CGFloat {
        isOn ? thumbOffsetOn : thumbInset
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
            .frame(width: width, height: height)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isOn ? .isSelected : [])
        .accessibilityValue(isOn ? Text("On") : Text("Off"))
    }

    private var track: some View {
        Capsule()
            .fill(trackFill)
            .frame(width: width, height: height)
    }

    private var thumb: some View {
        Circle()
            .fill(thumbFill)
            .frame(width: thumbSize, height: thumbSize)
            .shadow(
                color: .black.opacity(0.06),
                radius: thumbShadowRadiusSoft,
                x: 0,
                y: thumbShadowYOffset
            )
            .shadow(
                color: .black.opacity(0.15),
                radius: thumbShadowRadiusHard,
                x: 0,
                y: thumbShadowYOffset
            )
    }
}

struct AppToggleStyle: ToggleStyle {
    var height: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        AppToggle(height: height, isOn: configuration.$isOn)
    }
}

#Preview {
    struct PreviewContainer: View {
        @State private var isOnTop = true
        @State private var isOnBottom = false
        @State private var isToggleStyleOn = true

        var body: some View {
            let largeSize: CGFloat = 155
            let mediumSize: CGFloat = 78

            VStack(spacing: 24) {
                AppToggle(height: largeSize, isOn: $isOnTop)
                AppToggle(height: mediumSize, isOn: $isOnBottom)

                Toggle("Label", isOn: $isToggleStyleOn)
                    .toggleStyle(AppToggleStyle(height: mediumSize))
            }
            .padding(24)
            .background(Color.background)
        }
    }

    return PreviewContainer()
}
