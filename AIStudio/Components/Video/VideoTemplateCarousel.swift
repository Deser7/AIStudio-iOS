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
            
            Group {
                if #available(iOS 17.0, *) {
                    modernCarousel(
                        cardWidth: width,
                        cardHeight: height,
                        sideInset: inset
                    )
                } else {
                    legacyCarousel(
                        cardWidth: width,
                        cardHeight: height,
                        sideInset: inset
                    )
                }
            }
        }
        .aspectRatio(390 / 311, contentMode: .fit)
        .task {
            scrollPosition = selection.uuidString
        }
        .onChange(of: selection) {
            scrollPosition = $0.uuidString
        }
        .onChange(of: scrollPosition) { id in
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
    
    @available(iOS 17.0, *)
    private func modernCarousel(
        cardWidth: CGFloat,
        cardHeight: CGFloat,
        sideInset: CGFloat
    ) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            carouselContent(
                cardWidth: cardWidth,
                cardHeight: cardHeight,
                sideInset: sideInset
            )
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
                carouselContent(
                    cardWidth: cardWidth,
                    cardHeight: cardHeight,
                    sideInset: sideInset
                )
            }
            .onAppear {
                proxy.scrollTo(selection.uuidString, anchor: .center)
            }
            .onChange(of: selection) { id in
                withAnimation(.easeInOut(duration: 0.25)) {
                    proxy.scrollTo(id.uuidString, anchor: .center)
                }
            }
        }
        .frame(height: cardHeight)
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
