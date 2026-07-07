//
//  ChatHistoryView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct ChatHistoryView: View {
    @State private var viewModel: ChatHistoryViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: ChatHistoryViewModel = ChatHistoryViewModel()) {
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
            HistoryEmptyState()
        } else {
            historyList
        }
    }

    private var historyList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.sections) { section in
                    sectionView(for: section)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
    }

    @ViewBuilder
    private func sectionView(for section: ChatHistorySection) -> some View {
        if !section.items.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title)
                    .typography(style: .semiBold20)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(section.items) { item in
                    HistoryCard(
                        title: item.title,
                        subtitle: item.time,
                        action: { viewModel.itemTapped(item) }
                    )
                }
            }
        }
    }
}

#Preview("With History") {
    NavigationStack {
        ChatHistoryView()
    }
}

#Preview("Empty") {
    NavigationStack {
        ChatHistoryView(viewModel: ChatHistoryViewModel(sections: []))
    }
}
