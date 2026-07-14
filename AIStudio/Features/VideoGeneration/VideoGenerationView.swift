//
//  VideoGenerationView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct VideoGenerationView: View {
    @State private var viewModel = VideoGenerationViewModel()
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss

    private let gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    var body: some View {
        @Bindable var viewModel = viewModel

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
                        navigationPath.append(AppRoute.videoHistory)
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
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)

                PhotoAccessAlert(
                    onCancel: {
                        viewModel.photoAccessCancelled()
                    },
                    onPrimary: {
                        viewModel.beginPhotoAccessRequest()
                    }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.isPhotoAccessAlertPresented)
        .onChange(of: viewModel.detailContextToOpen) { _, context in
            guard let context else { return }
            navigationPath.append(AppRoute.videoTemplateDetail(context))
            viewModel.consumeDetailContextToOpen()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var templatesGrid: some View {
        LazyVGrid(columns: gridColumns, spacing: 16) {
            ForEach(viewModel.templates) { template in
                Button {
                    if let context = viewModel.templateTapped(template) {
                        navigationPath.append(AppRoute.videoTemplateDetail(context))
                    }
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
