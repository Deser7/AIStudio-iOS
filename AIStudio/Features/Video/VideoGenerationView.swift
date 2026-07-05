//
//  VideoGenerationView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct VideoGenerationView: View {
    @StateObject private var viewModel: VideoGenerationViewModel
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss

    private let gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    init(
        navigationPath: Binding<NavigationPath>,
        viewModel: VideoGenerationViewModel = VideoGenerationViewModel()
    ) {
        _navigationPath = navigationPath
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: viewModel.title,
                    style: .aiVideo,
                    preset: .main,
                    onBack: { dismiss() },
                    onRegenerate: {
                        navigationPath.append(AppRoute.chatHistory)
                    }
                )

                SectionsBar(
                    sections: viewModel.sectionNames,
                    selection: $viewModel.selectedSection
                )
                .padding(.bottom, 16)
                .padding(.top, 16)
                .padding(.horizontal, 8)

                ScrollView {
                    templatesGrid
                        .padding(.horizontal, 8)
                }
                .scrollIndicators(.hidden)
                .frame(maxHeight: .infinity)
            }

            if viewModel.isPhotoAccessAlertPresented {
                PhotoAccessAlert(
                    onCancel: {
                        viewModel.photoAccessCancelled()
                        dismiss()
                    },
                    onAllow: {
                        Task {
                            await viewModel.photoAccessAllowed()
                        }
                    }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.isPhotoAccessAlertPresented)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var templatesGrid: some View {
        LazyVGrid(columns: gridColumns, spacing: 16) {
            ForEach(viewModel.templates) { template in
                Button {
                    viewModel.templateTapped(template)
                } label: {
                    TitleCard(title: template.title)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            if viewModel.isSelected(template) {
                                AppShape.card
                                    .stroke(AppGradient.main, lineWidth: 2)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    NavigationStack {
        VideoGenerationView(navigationPath: .constant(NavigationPath()))
    }
}
