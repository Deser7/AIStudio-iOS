//
//  VideoGeneratingView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import SwiftUI

struct VideoGeneratingView: View {
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss

    @State private var didNavigateToResult = false

    private let generationDelay: TimeInterval = 2.5

    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack {
                ChatNavigationBar(
                    title: "",
                    style: .centeredTitle,
                    onBack: { dismiss() }
                )

                VStack {
                    generatingImage
                    statusTexts
                }

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task(id: navigationPath.count) {
            await runGenerationStub()
        }
    }

    private var generatingImage: some View {
        GeneratingImageView()
            .padding(.horizontal, 16)
    }

    private var statusTexts: some View {
        VStack(spacing: 8) {
            Text("Generating...")
                .typography(style: .semiBold20)
                .foregroundStyle(.white)

            Text("We're creating the best result for you")
                .typography(style: .regular16)
                .foregroundStyle(.price)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }

    @MainActor
    private func runGenerationStub() async {
        didNavigateToResult = false

        try? await Task.sleep(nanoseconds: UInt64(generationDelay * 1_000_000_000))

        guard !didNavigateToResult else { return }
        didNavigateToResult = true
        navigationPath.append(AppRoute.videoResult)
    }
}

#Preview {
    NavigationStack {
        VideoGeneratingView(navigationPath: .constant(NavigationPath()))
    }
}
