//
//  HomeView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 03.07.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var isSettingsPresented = false

    init(viewModel: HomeViewModel = HomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            StudioBackground()

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    SettingsButton {
                        isSettingsPresented = true
                    }
                }
                .padding()

                ScrollView {
                    VStack(spacing: 32) {
                        heroSection
                        promptInput
                        functionsSection
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView(
                notificationsEnabled: $viewModel.notificationsEnabled,
                cacheSize: viewModel.cacheSize,
                appVersion: viewModel.appVersion,
                onRateApp: viewModel.rateAppTapped,
                onShare: viewModel.shareTapped,
                onUpgradePlan: viewModel.upgradePlanTapped,
                onClearCache: viewModel.clearCacheTapped,
                onRestorePurchases: viewModel.restorePurchasesTapped,
                onContactUs: viewModel.contactUsTapped,
                onPrivacyPolicy: viewModel.privacyPolicyTapped,
                onUsagePolicy: viewModel.usagePolicyTapped
            )
            .presentationDragIndicator(.visible)
        }
    }

    private var heroSection: some View {
        VStack(spacing: 24) {
            SparkleIcon()
                .fill(AppGradient.main)
                .frame(width: 60, height: 60)

            Text(viewModel.title)
                .typography(style: .bold28)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
    }

    private var promptInput: some View {
        AppInput(text: $viewModel.promptText)
            .onSubmit(viewModel.promptSubmitted)
    }

    private var functionsSection: some View {
        FunctionsSection(
            onVideoTap: viewModel.videoTapped,
            onWritingTap: viewModel.writingTapped,
            onUnderstandTap: viewModel.understandTapped
        )
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    HomeView()
}
