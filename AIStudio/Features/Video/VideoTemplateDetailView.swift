//
//  VideoTemplateDetailView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import PhotosUI
import SwiftUI

struct VideoTemplateDetailView: View {
    @StateObject private var viewModel: VideoTemplateDetailViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var isPhotoPickerPresented = false

    private let addendumSize: CGFloat = 100
    private let carouselCardWidth: CGFloat = 280

    init(context: VideoTemplateDetailContext) {
        _viewModel = StateObject(
            wrappedValue: VideoTemplateDetailViewModel(context: context)
        )
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: viewModel.navigationTitle,
                    style: .centeredTitle,
                    onBack: { dismiss() }
                )

                templateCarousel
                    .padding(.top, 8)
                    .padding(.bottom, 24)

                photoAndSettingsSection
                    .padding(.horizontal, 16)

                Spacer(minLength: 24)

                SectionButton(title: "Create", style: .primary) {
                    viewModel.createTapped()
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
        .onChange(of: selectedPhotoItem) { newItem in
            Task {
                await loadPhoto(from: newItem)
            }
        }
    }

    private var templateCarousel: some View {
        TabView(selection: $viewModel.selectedTemplateID) {
            ForEach(viewModel.sectionTemplates) { template in
                TitleCard(title: "")
                    .frame(width: carouselCardWidth)
                    .tag(template.id)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: carouselCardWidth * (219 / 168))
    }

    private var photoAndSettingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            addendumView

            VideoTemplateExpandableSetting(
                title: "Format",
                options: AspectRatio.allCases,
                selection: $viewModel.aspectRatio,
                isExpanded: viewModel.expandedSetting == .format,
                onToggle: { viewModel.toggleSetting(.format) },
                onSelect: { viewModel.selectAspectRatio($0) }
            )

            VideoTemplateExpandableSetting(
                title: "Quality",
                options: VideoQuality.allCases,
                selection: $viewModel.videoQuality,
                isExpanded: viewModel.expandedSetting == .quality,
                onToggle: { viewModel.toggleSetting(.quality) },
                onSelect: { viewModel.selectVideoQuality($0) }
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
            if let uiImage = viewModel.selectedPhoto {
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
            let uiImage = UIImage(data: data)
        else {
            viewModel.resetPhoto()
            return
        }

        viewModel.setPhoto(uiImage)
    }
}

#Preview {
    NavigationStack {
        VideoTemplateDetailView(
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
