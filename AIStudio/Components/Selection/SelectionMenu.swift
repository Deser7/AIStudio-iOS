//
//  SelectionMenu.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct SelectionMenu<Option: SelectionMenuOption>: View {
    let options: [Option]
    @Binding var selection: Option

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                if index > 0 {
                    rowSeparator
                }

                SelectionMenuRow(
                    title: option.title,
                    isSelected: selection == option
                ) {
                    selection = option
                } trailing: {
                    option.trailingContent(isSelected: selection == option)
                }
            }
        }
        .padding(.vertical, 8)
        .frame(width: 358)
        .background(CardBlurBackground(opacity: 0.6))
    }

    private var rowSeparator: some View {
        Rectangle()
            .fill(.white.opacity(0.1))
            .frame(height: 1)
    }
}

#Preview("Format") {
    SelectionMenuPreview(
        options: AspectRatio.allCases,
        initial: .landscape16x9
    )
}

#Preview("Quality") {
    SelectionMenuPreview(
        options: VideoQuality.allCases,
        initial: .p720
    )
}

#Preview("Language") {
    SelectionMenuPreview(
        options: TextSelectionOption.languageSamples,
        initial: TextSelectionOption.languageSamples[0]
    )
}

private struct SelectionMenuPreview<Option: SelectionMenuOption>: View {
    let options: [Option]
    let initial: Option

    @State private var selection: Option

    init(options: [Option], initial: Option) {
        self.options = options
        self.initial = initial
        _selection = State(initialValue: initial)
    }

    var body: some View {
        SelectionMenu(options: options, selection: $selection)
            .padding(24)
            .background(Color.background)
    }
}
