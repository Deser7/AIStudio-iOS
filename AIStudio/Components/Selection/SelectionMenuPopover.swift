//
//  SelectionMenuPopover.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import SwiftUI

struct SelectionMenuPopover<Option: SelectionMenuOption>: View {
    let options: [Option]
    let selection: Option
    let onSelect: (Option) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                if index > 0 {
                    Rectangle()
                        .fill(.white.opacity(0.1))
                        .frame(height: 0.5)
                }

                SelectionMenuRow(
                    title: option.title,
                    isSelected: selection == option
                ) {
                    onSelect(option)
                } trailing: {
                    option.trailingContent(isSelected: selection == option)
                }
            }
        }
        .background {
            CardBlurBackground(opacity: 0.4)
        }
    }
}

extension View {
    func selectionMenuPopover<Option: SelectionMenuOption>(
        isExpanded: Bool,
        options: [Option],
        selection: Option,
        width: CGFloat = 175,
        onSelect: @escaping (Option) -> Void,
        onDismissOutside: @escaping () -> Void
    ) -> some View {
        overlay {
            if isExpanded {
                Color.clear
                    .frame(width: 9999, height: 9999)
                    .contentShape(Rectangle())
                    .onTapGesture(perform: onDismissOutside)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if isExpanded {
                SelectionMenuPopover(
                    options: options,
                    selection: selection,
                    onSelect: onSelect
                )
                .frame(width: width)
                .transition(
                    .opacity.combined(
                        with: .scale(scale: 0.96, anchor: .bottomTrailing)
                    )
                )
            }
        }
        .zIndex(isExpanded ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: isExpanded)
    }
}

#Preview {
    SelectionMenuPopover(
        options: VideoQuality.allCases,
        selection: .p720,
        onSelect: { _ in }
    )
    .frame(width: 175)
    .padding(24)
    .background(Color.background)
}
