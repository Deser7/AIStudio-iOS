//
//  VideoTemplateDetailView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import PhotosUI
import SwiftUI

struct VideoTemplateDetailView: View {
    @State private var viewModel: VideoTemplateDetailViewModel
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss

    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var isPhotoPickerPresented = false

    init(
        navigationPath: Binding<NavigationPath>,
        context: VideoTemplateDetailContext
    ) {
        _navigationPath = navigationPath
        _viewModel = State(
            initialValue: VideoTemplateDetailViewModel(context: context)
        )
    }

    var body: some View {
        @Bindable var viewModel = viewModel

        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: viewModel.navigationTitle,
                    style: .centeredTitle,
                    onBack: { dismiss() }
                )

                VideoTemplateCarousel(
                    templates: viewModel.sectionTemplates,
                    selection: $viewModel.selectedTemplateID
                )
                    .padding(.top, 8)
                    .padding(.bottom, 24)

                photoAndSettingsSection
                    .padding(.horizontal, 16)

                Spacer(minLength: 24)

                SectionButton(title: "Create", style: .primary) {
                    navigationPath.append(AppRoute.videoGenerating)
                }
                .disabled(!viewModel.isCreateEnabled)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .photosPicker(
            isPresented: $isPhotoPickerPresented,
            selection: $selectedPhotoItem,
            matching: .images
        )
        .onChange(of: selectedPhotoItem) { _, newItem in
            Task {
                await loadPhoto(from: newItem)
            }
        }
    }

    private let addendumSize: CGFloat = 100

    private var photoAndSettingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            addendumView

            VideoTemplateExpandableSetting(
                title: "Format",
                options: AspectRatio.allCases,
                selection: $viewModel.aspectRatio,
                isExpanded: viewModel.expandedSetting == .format,
                onToggle: { viewModel.toggleSetting(.format) },
                onSelect: { viewModel.selectAspectRatio($0) },
                onDismissOutside: { viewModel.expandedSetting = nil }
            )

            VideoTemplateExpandableSetting(
                title: "Quality",
                options: VideoQuality.allCases,
                selection: $viewModel.videoQuality,
                isExpanded: viewModel.expandedSetting == .quality,
                onToggle: { viewModel.toggleSetting(.quality) },
                onSelect: { viewModel.selectVideoQuality($0) },
                onDismissOutside: { viewModel.expandedSetting = nil }
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var addendumView: some View {
        switch viewModel.photoState {
        case .none:
            Addendum(size: addendumSize, content: .add {
                isPhotoPickerPresented = true
            })

        case .loading:
            Addendum(size: addendumSize, content: .loading)

        case .loaded:
            if let data = viewModel.selectedPhotoData,
               let uiImage = UIImage(data: data) {
                Addendum(
                    size: addendumSize,
                    content: .photo(Image(uiImage: uiImage)) {
                        selectedPhotoItem = nil
                        viewModel.resetPhoto()
                    }
                )
            }
        }
    }

    private func loadPhoto(from item: PhotosPickerItem?) async {
        guard let item else { return }

        viewModel.beginPhotoLoading()

        guard
            let data = try? await item.loadTransferable(type: Data.self),
            UIImage(data: data) != nil
        else {
            viewModel.resetPhoto()
            return
        }

        viewModel.setPhoto(data)
    }
}

#Preview {
    NavigationStack {
        VideoTemplateDetailView(
            navigationPath: .constant(NavigationPath()),
            context: VideoTemplateDetailContext(
                selectedTemplate: VideoTemplate(title: "Clay Fool"),
                sectionTemplates: [
                    VideoTemplate(title: "Clay Fool"),
                    VideoTemplate(title: "Title"),
                    VideoTemplate(title: "Title")
                ]
            )
        )
    }
}
