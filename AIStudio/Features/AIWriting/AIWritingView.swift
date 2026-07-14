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
                            text: $viewModel.inputText
                        )

                        TextInputCard(
                            isReadOnly: true,
                            showsCharacterCounter: false,
                            placeholder: "Your result will appear here...",
                            text: $viewModel.resultText
                        )

                        actionGrid

                        settingsSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }

                SectionButton(title: "Generate", style: .primary) {
                    viewModel.generateTapped()
                }
                .disabled(!viewModel.isGenerateEnabled)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
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

#Preview {
    NavigationStack {
        AIWritingView()
    }
}
