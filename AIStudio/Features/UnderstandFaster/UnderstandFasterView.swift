//
//  UnderstandFasterView.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 07.08.2026.
//

import SwiftUI

struct UnderstandFasterView: View {
    @State private var viewModel: SummaryViewModel
    @Environment(\.dismiss) private var dismiss

    init(files: [UnderstandImportedFile]? = nil) {
        let resolved = files ?? UnderstandFasterSession.consumePendingFiles()
        _viewModel = State(initialValue: SummaryViewModel(files: resolved))
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: "Summary",
                    style: .centeredTitle,
                    onBack: { dismiss() }
                )

                content
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            viewModel.startIfNeeded()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            loadingContent
        case .loaded:
            loadedContent
        case let .error(message):
            errorContent(message: message)
        }
    }

    private var loadingContent: some View {
        VStack(spacing: 16) {
            Spacer()
            SpinnerView(size: 40)
            Text(key: "Analyzing...")
                .typography(style: .semiBold20)
                .foregroundStyle(.white)
            Text(key: "We're extracting key points for you")
                .typography(style: .regular16)
                .foregroundStyle(.price)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var loadedContent: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    UnderstandSummaryCard(
                        badge: "Before",
                        title: viewModel.beforeTitle
                    ) {
                        DocumentStackPlaceholder()
                            .frame(minHeight: 140)
                    }

                    UnderstandSummaryCard(
                        badge: "After",
                        title: L10n.string("Key points")
                    ) {
                        SummaryKeyPointsList(points: viewModel.keyPoints)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }

            SectionButton(title: "Regenerate", style: .primary) {
                viewModel.regenerateTapped()
            }
            .disabled(!viewModel.isRegenerateEnabled)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }

    private func errorContent(message: String) -> some View {
        VStack(spacing: 16) {
            Spacer()
            Text(message)
                .typography(style: .regular16)
                .foregroundStyle(.error)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            SectionButton(title: "Regenerate", style: .primary) {
                viewModel.regenerateTapped()
            }
            .disabled(!viewModel.isRegenerateEnabled)
            .padding(.horizontal, 16)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview("Loaded") {
    NavigationStack {
        UnderstandFasterView(
            files: [
                UnderstandImportedFile(
                    fileName: "Contract.pdf",
                    mimeType: "application/pdf",
                    data: Data(),
                    kind: .pdf,
                    pageCount: 12
                )
            ]
        )
    }
    .environment(LanguageStore.shared)
    .preferredColorScheme(.dark)
}

#Preview("Loading") {
    let view = UnderstandFasterView(files: [])
    return NavigationStack {
        view
    }
    .environment(LanguageStore.shared)
    .preferredColorScheme(.dark)
}
