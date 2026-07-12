//
//  ChatHistoryView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftData
import SwiftUI

struct ChatHistoryView: View {
    @State private var viewModel: ChatHistoryViewModel
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss

    @State private var renameItem: ChatHistoryItem?
    @State private var renameText = ""

    init(
        navigationPath: Binding<NavigationPath>,
        modelContext: ModelContext
    ) {
        _navigationPath = navigationPath
        _viewModel = State(
            initialValue: ChatHistoryViewModel(
                repository: ChatHistoryRepository(modelContext: modelContext)
            )
        )
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
        .alert(
            "Rename",
            isPresented: Binding(
                get: { renameItem != nil },
                set: { if !$0 { renameItem = nil } }
            )
        ) {
            TextField("Title", text: $renameText)
            Button("Cancel", role: .cancel) {
                renameItem = nil
            }
            Button("Save") {
                guard let renameItem else { return }
                viewModel.rename(renameItem, to: renameText)
                self.renameItem = nil
            }
        }
        .onAppear {
            viewModel.reload()
        }
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
                Text(key: section.title)
                    .typography(style: .semiBold20)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(section.items) { item in
                    HistoryCard(
                        title: item.title,
                        subtitle: item.time,
                        action: { openChat(item) }
                    )
                    .contextMenu {
                        Button("Rename") {
                            renameText = item.title
                            renameItem = item
                        }
                        Button("Delete", role: .destructive) {
                            viewModel.delete(item)
                        }
                    }
                }
            }
        }
    }

    private func openChat(_ item: ChatHistoryItem) {
        var path = NavigationPath()
        path.append(AppRoute.chatSession(item.id))
        navigationPath = path
    }
}

#Preview("With History") {
    let container = ChatHistoryPreviewSupport.container(seedSample: true)
    NavigationStack {
        ChatHistoryView(
            navigationPath: .constant(NavigationPath()),
            modelContext: container.mainContext
        )
    }
    .modelContainer(container)
}

#Preview("Empty") {
    let container = ChatHistoryPreviewSupport.container()
    NavigationStack {
        ChatHistoryView(
            navigationPath: .constant(NavigationPath()),
            modelContext: container.mainContext
        )
    }
    .modelContainer(container)
}
