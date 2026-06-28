//
//  SectionsBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

/// Горизонтальный ряд чипов секций (Figma «Sections»).
struct SectionsBar: View {
    let sections: [String]
    var height: CGFloat
    @Binding var selection: String
    var onSelect: ((String) -> Void)?

    /// Figma ref chip height = 33.
    private var chipSpacing: CGFloat { height * 8 / 33 }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: chipSpacing) {
                ForEach(sections, id: \.self) { section in
                    SectionChip(
                        title: section,
                        height: height,
                        isSelected: selection == section
                    ) {
                        selection = section
                        onSelect?(section)
                    }
                }
            }
        }
    }
}

#Preview {
    SectionsBarPreview()
}

private struct SectionsBarPreview: View {
    @State private var selection = "Popular"
    private let size: CGFloat = 33

    var body: some View {
        SectionsBar(
            sections: ["Popular", "Funny", "Sad", "Trends", "Dances"],
            height: size,
            selection: $selection
        )
        .padding(24)
        .background(Color.background)
    }
}
