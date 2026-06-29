//
//  SelectionMenu.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

protocol SelectionMenuOption: Identifiable, Hashable {
    var title: String { get }
    func trailingContent(isSelected: Bool) -> AnyView
}

extension SelectionMenuOption {
    func trailingContent(isSelected: Bool) -> AnyView {
        AnyView(EmptyView())
    }
}

extension AspectRatio: Identifiable, SelectionMenuOption {
    var id: Self { self }

    func trailingContent(isSelected: Bool) -> AnyView {
        AnyView(AspectRatioIcon(ratio: self, isSelected: isSelected))
    }
}

enum VideoQuality: String, CaseIterable, Identifiable, SelectionMenuOption, Sendable {
    case p540 = "540p"
    case p720 = "720p"
    case p1080 = "1080p"
    case k4 = "4K"

    var id: String { rawValue }
    var title: String { rawValue }
}

/// Универсальное меню выбора (Figma «Format», «Quality», «Language», «Style», 358).
struct SelectionMenu<Option: SelectionMenuOption>: View {
    let options: [Option]
    @Binding var selection: Option

    @Environment(\.displayScale) private var displayScale

    private var separatorHeight: CGFloat {
        max(0.5, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
    }

    private var cardContentHeight: CGFloat {
        let rows = CGFloat(options.count)
        let separators = CGFloat(max(options.count - 1, 0))
        return rows * 44 + separators * separatorHeight + 16
    }

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
        .background { cardBackground }
        .clipShape(shape)
    }

    private var rowSeparator: some View {
        Rectangle()
            .fill(.white.opacity(0.1))
            .frame(height: separatorHeight)
    }

    private var cardBackground: some View {
        BlurCardBackground(
            style: .bar,
            extent: cardContentHeight,
            blurRadius: AppSurface.blurRadius,
            cardOpacity: 0.6,
            shape: shape
        )
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

struct TextSelectionOption: SelectionMenuOption, Hashable, Sendable {
    let title: String
    var id: String { title }

    static let languageSamples: [TextSelectionOption] = [
        TextSelectionOption(title: "Original"),
        TextSelectionOption(title: "English"),
        TextSelectionOption(title: "Spanish"),
    ]

    static let styleSamples: [TextSelectionOption] = [
        TextSelectionOption(title: "Original"),
        TextSelectionOption(title: "Professional"),
        TextSelectionOption(title: "Casual"),
    ]
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
