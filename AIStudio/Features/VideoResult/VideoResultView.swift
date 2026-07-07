//
//  VideoResultView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import SwiftUI

struct VideoResultView: View {
    @State private var viewModel: VideoResultViewModel
    @Binding var navigationPath: NavigationPath

    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
        _viewModel = State(initialValue: VideoResultViewModel())
    }

    var body: some View {
        @Bindable var viewModel = viewModel

        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: "Result",
                    style: .centeredTitle,
                    onBack: popToTemplateDetail
                )

                ResultCard(
                    onReplace: regenerateVideo,
                    onPlay: {}
                )
                .padding(.horizontal, 8)

                Spacer(minLength: 16)

                actionButtons
                    .padding(.horizontal, 8)
                    .padding(.bottom)
            }
            .allowsHitTesting(viewModel.overlay == .none)

            overlayContent
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.overlay)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $viewModel.isShareSheetPresented) {
            ActivityShareSheet(items: [viewModel.resultVideoURL])
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 16) {
            SectionButton(title: "Share", style: .secondary) {
                viewModel.shareTapped()
            }
            SectionButton(title: "Download", style: .primary) {
                viewModel.downloadTapped()
            }
        }
    }

    @ViewBuilder
    private var overlayContent: some View {
        switch viewModel.overlay {
        case .none:
            EmptyView()

        case .saving:
            scrim

        case .savedNotification:
            ZStack {
                scrim
                    .onTapGesture(perform: viewModel.dismissNotification)

                AppNotification(
                    content: .videoSaved(message: viewModel.savedNotificationMessage)
                )
                .onTapGesture(perform: viewModel.dismissNotification)
            }

        case .photoAccessSettings:
            ZStack {
                scrim

                PhotoAccessAlert(
                    title: "Photo access required",
                    message: "Allow access in Settings to save videos to your gallery.",
                    primaryButtonTitle: "Open Settings",
                    onCancel: viewModel.photoAccessSettingsCancelled,
                    onPrimary: viewModel.openPhotoSettings
                )
            }
        }
    }

    private var scrim: some View {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
            .transition(.opacity)
    }

    private func popToTemplateDetail() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    private func regenerateVideo() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
        navigationPath.append(AppRoute.videoGenerating)
    }
}

#Preview {
    NavigationStack {
        VideoResultView(navigationPath: .constant(NavigationPath()))
    }
}
