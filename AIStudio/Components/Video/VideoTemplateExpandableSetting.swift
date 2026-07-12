//
//  VideoTemplateExpandableSetting.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct VideoTemplateExpandableSetting<Option: SelectionMenuOption>: View {
    let title: String
    let options: [Option]
    @Binding var selection: Option
    let isExpanded: Bool
    let onToggle: () -> Void
    let onSelect: (Option) -> Void
    var onDismissOutside: () -> Void = {}

    var body: some View {
        triggerRow
            .selectionMenuPopover(
                isExpanded: isExpanded,
                options: options,
                selection: selection,
                onSelect: onSelect,
                onDismissOutside: onDismissOutside
            )
    }

    private var triggerRow: some View {
        Button(action: onToggle) {
            HStack {
                Text(key: title)
                    .typography(style: .medium16)
                    .foregroundStyle(.white.opacity(0.6))

                Spacer(minLength: 12)

                if !isExpanded {
                    Text(key: selection.title)
                        .typography(style: .medium16)
                        .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background {
                CardBlurBackground(opacity: 0.5)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview("Format popover") {
    FormatSettingPreview()
}

#Preview("Quality collapsed") {
    QualitySettingPreview()
}

private struct FormatSettingPreview: View {
    @State private var selection: AspectRatio = .landscape16x9
    @State private var expanded = true

    var body: some View {
        VideoTemplateExpandableSetting(
            title: "Format",
            options: AspectRatio.allCases,
            selection: $selection,
            isExpanded: expanded,
            onToggle: { expanded.toggle() },
            onSelect: { option in
                selection = option
                expanded = false
            },
            onDismissOutside: { expanded = false }
        )
        .padding(.horizontal, 16)
        .padding(.top, 120)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

private struct QualitySettingPreview: View {
    @State private var selection: VideoQuality = .p1080
    @State private var expanded = false

    var body: some View {
        VideoTemplateExpandableSetting(
            title: "Quality",
            options: VideoQuality.allCases,
            selection: $selection,
            isExpanded: expanded,
            onToggle: { expanded.toggle() },
            onSelect: { option in
                selection = option
                expanded = false
            },
            onDismissOutside: { expanded = false }
        )
        .padding(.horizontal, 16)
        .padding(.top, 120)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}
