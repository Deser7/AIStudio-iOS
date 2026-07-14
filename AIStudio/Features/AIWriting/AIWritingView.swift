//
//  AIWritingView.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 13.07.2026.
//

import SwiftUI

struct AIWritingView: View {
    @State private var viewModel = AIWritingViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isInputFocused: Bool

    var body: some View {

        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: "AI Writing",
                    style: .centeredTitle,
                    onBack: { dismiss() }
                )

                ScrollView {
                    VStack(spacing: 16) {
                        TextInputCard(
                            characterLimit: viewModel.characterLimit,
                            isFocused: $isInputFocused,
                            text: $viewModel.inputText
                        )

                        VStack(spacing: 16) {
                            TextResultCard(text: viewModel.resultText)

                            actionGrid

                            settingsSection
                        }
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                        .simultaneousGesture(
                            TapGesture().onEnded { isInputFocused = false }
                        )
                        
                        SectionButton(title: "Generate", style: .primary) {
                            isInputFocused = false
                            viewModel.generateTapped()
                        }
                        .disabled(!viewModel.isGenerateEnabled)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
                .scrollDismissesKeyboard(.immediately)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var actionGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ],
            spacing: 12
        ) {
            ForEach(WritingAction.allCases) { action in
                WritingActionChip(
                    title: action.title,
                    isSelected: viewModel.selectedAction == action
                ) {
                    viewModel.selectAction(action)
                }
            }
        }
    }

    private var settingsSection: some View {
        VStack(spacing: 16) {
            VideoTemplateExpandableSetting(
                title: "Translate",
                options: viewModel.translateOptions,
                selection: $viewModel.translateOption,
                isExpanded: viewModel.expandedSetting == .translate,
                onToggle: { viewModel.toggleSetting(.translate) },
                onSelect: { viewModel.selectTranslate($0) },
                onDismissOutside: { viewModel.expandedSetting = nil },
                showsChevron: true,
                valueUsesGradient: true
            )

            VideoTemplateExpandableSetting(
                title: "Style",
                options: viewModel.styleOptions,
                selection: $viewModel.styleOption,
                isExpanded: viewModel.expandedSetting == .style,
                onToggle: { viewModel.toggleSetting(.style) },
                onSelect: { viewModel.selectStyle($0) },
                onDismissOutside: { viewModel.expandedSetting = nil },
                showsChevron: true
            )
        }
    }
}

#Preview("English") {
    NavigationStack {
        AIWritingView()
    }
    .environment(LanguageStore.shared)
    .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Russian") {
    NavigationStack {
        AIWritingView()
    }
    .environment(LanguageStore.shared)
    .environment(\.locale, Locale(identifier: "ru"))
}
