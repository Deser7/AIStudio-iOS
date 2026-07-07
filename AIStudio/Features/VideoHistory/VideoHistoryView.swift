//
//  VideoHistoryView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 07.07.2026.
//

import SwiftUI

struct VideoHistoryView: View {
    @State private var viewModel: VideoHistoryViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: VideoHistoryViewModel = VideoHistoryViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: viewModel.title,
                    style: .centeredTitle,
                    onBack: { dismiss() }
                )

                content
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isEmpty {
            VideoHistoryEmptyState()
        } else {
            historyGrid
        }
    }

    private var historyGrid: some View {
        ScrollView {
            MasonryGrid(
                items: viewModel.items,
                spacing: 8,
                weight: { 1 / $0.aspectRatio }
            ) { item in
                VideoHistoryCard(item: item) {
                    viewModel.itemTapped(item)
                }
            }
            .padding(16)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview("With History") {
    NavigationStack {
        VideoHistoryView()
    }
}

#Preview("Empty") {
    NavigationStack {
        VideoHistoryView(viewModel: VideoHistoryViewModel(items: []))
    }
}
