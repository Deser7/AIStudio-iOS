//
//  ChatView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isComposerFocused: Bool

    init(
        navigationPath: Binding<NavigationPath>,
        viewModel: ChatViewModel = ChatViewModel()
    ) {
        _navigationPath = navigationPath
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
                    onRegenerate: {
                        isComposerFocused = false
                        navigationPath.append(AppRoute.chatHistory)
                    }
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
            messagesList
        }
    }

    private var messagesList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.messages) { message in
                        messageView(for: message)
                            .id(message.id)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }
            .onChange(of: viewModel.messages.last?.id) { _ in
                scrollToBottom(using: proxy)
            }
        }
    }

    private var composer: some View {
        ComposerInput(
            placeholder: viewModel.composerPlaceholder,
            autofocus: viewModel.showsEmptyState,
            text: $viewModel.promptText,
            isFocused: $isComposerFocused,
            onImport: viewModel.importTapped,
            onMicro: viewModel.microTapped,
            onSend: {
                isComposerFocused = false
                viewModel.sendTapped()
            },
            onCancelRecording: {},
            onConfirmRecording: {}
        )
    }

    @ViewBuilder
    private func messageView(for message: ChatMessage) -> some View {
        switch message {
        case let .user(_, text):
            UserPrompt(text: text)
                .frame(maxWidth: .infinity, alignment: .trailing)

        case .generating:
            AIResponseIndicator()
                .frame(maxWidth: .infinity, alignment: .leading)

        case let .assistant(_, content):
            AIResponseBubble(
                content: content,
                onCopy: viewModel.copyResponseTapped,
                onRefresh: viewModel.refreshResponseTapped
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func scrollToBottom(using proxy: ScrollViewProxy) {
        guard let lastID = viewModel.messages.last?.id else { return }

        withAnimation(.easeOut(duration: 0.25)) {
            proxy.scrollTo(lastID, anchor: .bottom)
        }
    }
}

#Preview("Empty") {
    NavigationStack {
        ChatView(navigationPath: .constant(NavigationPath()))
    }
}
