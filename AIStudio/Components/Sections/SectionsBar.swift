//
//  SectionsBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct SectionsBar: View {
    let sections: [String]
    @Binding var selection: String
    var onSelect: ((String) -> Void)?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(sections, id: \.self) { section in
                    SectionChip(
                        title: section,
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

    var body: some View {
        SectionsBar(
            sections: ["Popular", "Funny", "Sad", "Trends", "Dances"],
            selection: $selection
        )
        .padding(24)
        .background(Color.background)
    }
}
