//
//  VideoTemplateCarousel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

enum VideoTemplateCarouselLayout {
    static let referenceScreenWidth: CGFloat = 390
    static let cardWidth: CGFloat = 331
    static let cardHeight: CGFloat = 311
    static let itemSpacing: CGFloat = 12

    static func metrics(for containerWidth: CGFloat) -> (cardWidth: CGFloat, cardHeight: CGFloat) {
        let scale = containerWidth / referenceScreenWidth
        return (cardWidth * scale, cardHeight * scale)
    }

    static func sideInset(containerWidth: CGFloat, cardWidth: CGFloat) -> CGFloat {
        max(0, (containerWidth - cardWidth) / 2)
    }
}

private struct CarouselDisplayItem: Identifiable {
    let id: String
    let template: VideoTemplate
    let selectionID: UUID
}

struct VideoTemplateCarousel: View {
    let templates: [VideoTemplate]
    @Binding var selection: UUID

    @State private var scrollPosition: String?

    private var displayItems: [CarouselDisplayItem] {
        guard templates.count > 1 else {
            return templates.map {
                CarouselDisplayItem(
                    id: $0.id.uuidString,
                    template: $0,
                    selectionID: $0.id
                )
            }
        }

        var items: [CarouselDisplayItem] = []
        let last = templates[templates.count - 1]
        let first = templates[0]

        items.append(
            CarouselDisplayItem(
                id: "leading-\(last.id.uuidString)",
                template: last,
                selectionID: last.id
            )
        )

        items.append(
            contentsOf: templates.map {
                CarouselDisplayItem(
                    id: $0.id.uuidString,
                    template: $0,
                    selectionID: $0.id
                )
            }
        )

        items.append(
            CarouselDisplayItem(
                id: "trailing-\(first.id.uuidString)",
                template: first,
                selectionID: first.id
            )
        )

        return items
    }

    var body: some View {
        GeometryReader { geometry in
            let metrics = VideoTemplateCarouselLayout.metrics(for: geometry.size.width)
            let sideInset = VideoTemplateCarouselLayout.sideInset(
                containerWidth: geometry.size.width,
                cardWidth: metrics.cardWidth
            )

            if #available(iOS 17.0, *) {
                alignedCarousel(
                    cardWidth: metrics.cardWidth,
                    cardHeight: metrics.cardHeight,
                    sideInset: sideInset
                )
            } else {
                legacyCarousel(
                    cardWidth: metrics.cardWidth,
                    cardHeight: metrics.cardHeight,
                    sideInset: sideInset
                )
            }
        }
        .aspectRatio(
            VideoTemplateCarouselLayout.referenceScreenWidth / VideoTemplateCarouselLayout.cardHeight,
            contentMode: .fit
        )
        .onAppear {
            scrollPosition = selection.uuidString
        }
        .onChange(of: selection) { newSelection in
            scrollPosition = newSelection.uuidString
        }
        .onChange(of: scrollPosition) { newPosition in
            guard
                let newPosition,
                let item = displayItems.first(where: { $0.id == newPosition }),
                item.selectionID != selection
            else {
                return
            }

            selection = item.selectionID
        }
    }

    @available(iOS 17.0, *)
    private func alignedCarousel(
        cardWidth: CGFloat,
        cardHeight: CGFloat,
        sideInset: CGFloat
    ) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: VideoTemplateCarouselLayout.itemSpacing) {
                ForEach(displayItems) { item in
                    VideoTemplateCarouselCard()
                        .frame(width: cardWidth, height: cardHeight)
                        .id(item.id)
                }
            }
            .padding(.horizontal, sideInset)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .frame(height: cardHeight)
    }

    private func legacyCarousel(
        cardWidth: CGFloat,
        cardHeight: CGFloat,
        sideInset: CGFloat
    ) -> some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: VideoTemplateCarouselLayout.itemSpacing) {
                    ForEach(displayItems) { item in
                        VideoTemplateCarouselCard()
                            .frame(width: cardWidth, height: cardHeight)
                            .id(item.id)
                    }
                }
                .padding(.horizontal, sideInset)
            }
            .onAppear {
                proxy.scrollTo(selection.uuidString, anchor: .center)
            }
            .onChange(of: selection) { newSelection in
                withAnimation(.easeInOut(duration: 0.25)) {
                    proxy.scrollTo(newSelection.uuidString, anchor: .center)
                }
            }
        }
        .frame(height: cardHeight)
    }
}

#Preview {
    struct PreviewContainer: View {
        private let firstID = UUID()
        private let secondID = UUID()
        private let thirdID = UUID()
        @State private var selection: UUID

        init() {
            _selection = State(initialValue: secondID)
        }

        var body: some View {
            VideoTemplateCarousel(
                templates: [
                    VideoTemplate(id: firstID, title: "First"),
                    VideoTemplate(id: secondID, title: "Clay Fool"),
                    VideoTemplate(id: thirdID, title: "Third")
                ],
                selection: $selection
            )
            .background(Color.background)
        }
    }

    return PreviewContainer()
}
