//
//  FadingStreamingParagraph.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct FadingStreamingParagraph: View {
    let text: String
    let isStreaming: Bool
    let color: Color

    @State private var committed = ""
    @State private var incoming = ""
    @State private var incomingOpacity = 1.0

    private static let fadeDuration: Animation = .easeOut(duration: 0.4)

    var body: some View {
        Group {
            if isStreaming {
                fadingText
            } else {
                SelectableText(text, style: .regular16, color: color)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            commitFully(text)
        }
        .onChange(of: text) { _, newValue in
            applyTextChange(newValue)
        }
        .onChange(of: isStreaming) { _, streaming in
            if !streaming {
                commitFully(text)
            }
        }
    }

    private var fadingText: some View {
        (
            Text(committed)
                .foregroundStyle(color)
            + Text(incoming)
                .foregroundStyle(color.opacity(incomingOpacity))
        )
        .typography(style: .regular16)
        .tracking(0)
        .lineSpacing(0)
        .multilineTextAlignment(.leading)
    }

    private func applyTextChange(_ newValue: String) {
        guard isStreaming else {
            commitFully(newValue)
            return
        }

        let visible = committed + incoming
        if newValue.hasPrefix(visible) {
            committed = visible
            incoming = String(newValue.dropFirst(visible.count))
        } else if newValue.hasPrefix(committed) {
            incoming = String(newValue.dropFirst(committed.count))
        } else {
            commitFully(newValue)
            return
        }

        guard !incoming.isEmpty else {
            incomingOpacity = 1
            return
        }

        incomingOpacity = 0
        withAnimation(Self.fadeDuration) {
            incomingOpacity = 1
        }
    }

    private func commitFully(_ value: String) {
        committed = value
        incoming = ""
        incomingOpacity = 1
    }
}

#Preview("Static") {
    FadingStreamingParagraph(
        text: "Static paragraph without streaming fade.",
        isStreaming: false,
        color: .white.opacity(0.8)
    )
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.background)
}

#Preview("Streaming") {
    FadingStreamingParagraph(
        text: "Soft fade appears on each new chunk of the reply.",
        isStreaming: true,
        color: .white.opacity(0.8)
    )
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.background)
}
