//
//  VideoTemplateCarousel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct VideoTemplateCarousel: View {
    let templates: [VideoTemplate]
    @Binding var selection: UUID

    @State private var scrollPosition: String?

    private var carouselTemplates: [VideoTemplate] {
        guard templates.count > 1,
              let first = templates.first,
              let last = templates.last
        else {
            return templates
        }

        return [last] + templates + [first]
    }

    var body: some View {
        GeometryReader { geo in
            let scale = geo.size.width / 390

            let width = 331 * scale
            let height = 311 * scale
            let inset = max(0, (geo.size.width - width) / 2)

            ScrollView(.horizontal, showsIndicators: false) {
                carouselContent(
                    cardWidth: width,
                    cardHeight: height,
                    sideInset: inset
                )
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .frame(height: height)
        }
        .aspectRatio(390 / 311, contentMode: .fit)
        .task {
            scrollPosition = selection.uuidString
        }
        .onChange(of: selection) {
            scrollPosition = selection.uuidString
        }
        .onChange(of: scrollPosition) { _, id in
            guard
                let id,
                let template = template(for: id),
                template.id != selection
            else { return }

            selection = template.id
        }
    }

    @ViewBuilder
    private func carouselContent(
        cardWidth: CGFloat,
        cardHeight: CGFloat,
        sideInset: CGFloat
    ) -> some View {

        HStack(spacing: 12) {
            ForEach(Array(carouselTemplates.enumerated()), id: \.offset) { index, template in
                VideoTemplateCarouselCard()
                    .frame(width: cardWidth, height: cardHeight)
                    .id(scrollID(for: template, index: index))
            }
        }
        .padding(.horizontal, sideInset)
    }

    private func scrollID(
        for template: VideoTemplate,
        index: Int
    ) -> String {

        switch index {
        case 0 where templates.count > 1:
            return "leading-\(template.id)"

        case carouselTemplates.count - 1 where templates.count > 1:
            return "trailing-\(template.id)"

        default:
            return template.id.uuidString
        }
    }

    private func template(for id: String) -> VideoTemplate? {
        templates.first {
            id.hasSuffix($0.id.uuidString)
        }
    }
}

#Preview {
    VideoTemplateCarouselPreview()
}

private struct VideoTemplateCarouselPreview: View {
    private let templates: [VideoTemplate]
    @State private var selection: UUID

    init() {
        let templates = [
            VideoTemplate(title: "First"),
            VideoTemplate(title: "Clay Fool"),
            VideoTemplate(title: "Third")
        ]
        self.templates = templates
        _selection = State(initialValue: templates[1].id)
    }

    var body: some View {
        VideoTemplateCarousel(
            templates: templates,
            selection: $selection
        )
        .background(Color.background)
    }
}
