//
//  MasonryGrid.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 07.07.2026.
//

import SwiftUI

struct MasonryGrid<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let spacing: CGFloat
    let weight: (Item) -> CGFloat
    let content: (Item) -> Content

    init(
        items: [Item],
        spacing: CGFloat = 8,
        weight: @escaping (Item) -> CGFloat,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self.weight = weight
        self.content = content
    }

    var body: some View {
        let columns = distribute(items)

        HStack(alignment: .top, spacing: spacing) {
            columnView(for: columns.left)
            columnView(for: columns.right)
        }
    }

    private func columnView(for items: [Item]) -> some View {
        LazyVStack(spacing: spacing) {
            ForEach(items) { item in
                content(item)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func distribute(_ items: [Item]) -> (left: [Item], right: [Item]) {
        var left: [Item] = []
        var right: [Item] = []
        var leftWeight: CGFloat = 0
        var rightWeight: CGFloat = 0

        for item in items {
            let itemWeight = weight(item)

            if leftWeight <= rightWeight {
                left.append(item)
                leftWeight += itemWeight
            } else {
                right.append(item)
                rightWeight += itemWeight
            }
        }

        return (left, right)
    }
}

#Preview {
    ScrollView {
        MasonryGrid(
            items: VideoHistoryStub.items,
            spacing: 8,
            weight: { 1 / $0.aspectRatio }
        ) { item in
            VideoHistoryCard(item: item, action: {})
        }
        .padding(16)
    }
    .background(Color.background)
}
