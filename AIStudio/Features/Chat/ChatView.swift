//
//  ChatView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: ChatViewModel = ChatViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            AppGradient.background.ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: viewModel.title,
                    subtitle: viewModel.subtitle,
                    style: .aiChat,
                    preset: .main,
                    onBack: { dismiss() },
                    onRegenerate: viewModel.regenerateTapped
                )

                content
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            composer
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.showsEmptyState {
            Spacer(minLength: 0)
            ChatEmptyState()
            Spacer(minLength: 0)
        } else {
            Spacer(minLength: 0)
        }
    }

    private var composer: some View {
        ComposerInput(
            placeholder: "Ask anything...",
            autofocus: true,
            text: $viewModel.promptText,
            onImport: viewModel.importTapped,
            onMicro: viewModel.microTapped,
            onSend: viewModel.sendTapped,
            onCancelRecording: {},
            onConfirmRecording: {}
        )
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
