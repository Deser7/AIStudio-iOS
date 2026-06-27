//
//  SelectionMenu.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Опция универсального меню выбора.
protocol SelectionMenuOption: Identifiable, Hashable {
    var title: String { get }
    func trailingContent(rowSize: CGFloat, isSelected: Bool) -> AnyView
}

extension SelectionMenuOption {
    func trailingContent(rowSize: CGFloat, isSelected: Bool) -> AnyView {
        AnyView(EmptyView())
    }
}

extension AspectRatio: Identifiable, SelectionMenuOption {
    var id: Self { self }

    func trailingContent(rowSize: CGFloat, isSelected: Bool) -> AnyView {
        AnyView(AspectRatioIcon(ratio: self, rowSize: rowSize, isSelected: isSelected))
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

/// Универсальное меню выбора (Figma «Format», «Quality», «Language», «Style»).
struct SelectionMenu<Option: SelectionMenuOption>: View {
    let options: [Option]
    var size: CGFloat
    @Binding var selection: Option

    @Environment(\.displayScale) private var displayScale

    /// Figma ref width = 358. Базовая единица — 16px.
    private var spacing: CGFloat { size * 16 / 358 }
    private var rowHeight: CGFloat { size * 44 / 358 }
    private var verticalPadding: CGFloat { spacing * 8 / 16 }
    private var cornerRadius: CGFloat { spacing * 24 / 16 }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }

    private var separatorHeight: CGFloat {
        max(spacing * 0.5 / 16, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }

    private var cardContentHeight: CGFloat {
        let rows = CGFloat(options.count)
        let separators = CGFloat(max(options.count - 1, 0))
        return rows * rowHeight + separators * separatorHeight + verticalPadding * 2
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                if index > 0 {
                    rowSeparator
                }

                SelectionMenuRow(
                    title: option.title,
                    size: rowHeight,
                    isSelected: selection == option
                ) {
                    selection = option
                } trailing: {
                    option.trailingContent(
                        rowSize: rowHeight,
                        isSelected: selection == option
                    )
                }
            }
        }
        .padding(.vertical, verticalPadding)
        .frame(width: size)
        .background { cardBackground }
        .clipShape(shape)
    }

    private var rowSeparator: some View {
        Color.white.opacity(AppSurface.Interaction.faintOpacity)
            .frame(height: separatorHeight)
    }

    private var cardBackground: some View {
        BlurCardBackground(
            style: .bar,
            size: cardContentHeight,
            blurRadius: blurRadius,
            cardOpacity: AppSurface.CardOpacity.fill,
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
        SelectionMenu(options: options, size: 358, selection: $selection)
            .padding(24)
            .background(Color.background)
    }
}
