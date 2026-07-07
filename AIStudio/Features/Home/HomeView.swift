//
//  HomeView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 03.07.2026.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    @State private var isSettingsPresented = false
    @State private var navigationPath = NavigationPath()

    init(viewModel: HomeViewModel = HomeViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack(path: $navigationPath) {
            homeContent
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .chat:
                        ChatView(navigationPath: $navigationPath)
                    case .chatHistory:
                        ChatHistoryView()
                    case .videoGeneration:
                        VideoGenerationView(navigationPath: $navigationPath)
                    case .videoHistory:
                        VideoHistoryView()
                    case let .videoTemplateDetail(context):
                        VideoTemplateDetailView(
                            navigationPath: $navigationPath,
                            context: context
                        )
                    case .videoGenerating:
                        VideoGeneratingView(navigationPath: $navigationPath)
                    case .videoResult:
                        VideoResultView(navigationPath: $navigationPath)
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

    private var homeContent: some View {
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
        .navigationBarHidden(true)
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
        NavigationLink(value: AppRoute.chat) {
            AppInput(isEnabled: false, text: .constant(""))
                .contentShape(AppShape.card)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Ask anything"))
        .accessibilityHint(Text("Opens AI Chat"))
    }

    private var functionsSection: some View {
        FunctionsSection(
            onVideoTap: { navigationPath.append(AppRoute.videoGeneration) },
            onWritingTap: viewModel.writingTapped,
            onUnderstandTap: viewModel.understandTapped
        )
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    HomeView()
}
