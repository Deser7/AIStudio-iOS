//
//  HomeView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 03.07.2026.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var isSettingsPresented = false
    @State private var navigationPath = NavigationPath()
    @State private var isUnderstandImporterPresented = false
    @State private var understandImportError: String?
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack(path: $navigationPath) {
            homeContent
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .chat:
                        ChatView(
                            sessionID: nil,
                            navigationPath: $navigationPath,
                            modelContext: modelContext
                        )
                        .id("new-chat")
                    case let .chatSession(id):
                        ChatView(
                            sessionID: id,
                            navigationPath: $navigationPath,
                            modelContext: modelContext
                        )
                        .id(id)
                    case .chatHistory:
                        ChatHistoryView(
                            navigationPath: $navigationPath,
                            modelContext: modelContext
                        )
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
                    case .aiWriting:
                        AIWritingView()
                    case .understandFaster:
                        UnderstandFasterView()
                    }
                }
        }
        .fileImporter(
            isPresented: $isUnderstandImporterPresented,
            allowedContentTypes: UnderstandFileImportSupport.allowedContentTypes,
            allowsMultipleSelection: true
        ) { result in
            handleUnderstandImport(result)
        }
        .alert(
            "Couldn't import files",
            isPresented: Binding(
                get: { understandImportError != nil },
                set: { if !$0 { understandImportError = nil } }
            )
        ) {
            Button("OK", role: .cancel) {
                understandImportError = nil
            }
        } message: {
            if let understandImportError {
                Text(understandImportError)
            }
        }
        .fullScreenCover(isPresented: $isSettingsPresented) {
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

            Text(key: viewModel.title)
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
            onWritingTap: { navigationPath.append(AppRoute.aiWriting) },
            onUnderstandTap: { isUnderstandImporterPresented = true }
        )
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private func handleUnderstandImport(_ result: Result<[URL], Error>) {
        switch UnderstandFileImportSupport.load(from: result) {
        case let .success(files):
            UnderstandFasterSession.enqueue(files)
            navigationPath.append(AppRoute.understandFaster)
        case let .failure(error):
            guard error != .cancelled else { return }
            understandImportError = L10n.string(String.LocalizationValue(error.messageKey))
        }
    }
}

#Preview {
    let container = ChatHistoryPreviewSupport.container()
    HomeView()
        .environment(LanguageStore.shared)
        .environment(\.locale, LanguageStore.shared.locale)
        .modelContainer(container)
}
