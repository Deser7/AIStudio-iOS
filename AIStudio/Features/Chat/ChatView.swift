//
//  ChatView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 04.07.2026.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ChatView: View {
    @State private var viewModel: ChatViewModel
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @FocusState private var isComposerFocused: Bool
    @State private var userInterruptedScroll = false
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    @State private var isImportMenuExpanded = false
    @State private var isDirectionMenuExpanded = false

    init(
        sessionID: UUID? = nil,
        navigationPath: Binding<NavigationPath>,
        modelContext: ModelContext
    ) {
        _navigationPath = navigationPath
        _viewModel = State(
            initialValue: ChatViewModel(
                sessionID: sessionID,
                repository: ChatHistoryRepository(modelContext: modelContext)
            )
        )
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .simultaneousGesture(
                    TapGesture().onEnded {
                        isComposerFocused = false
                    }
                )

            if let alert = viewModel.mediaAccessAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)

                mediaAccessAlert(for: alert)
                    .transition(.opacity)
            }

            if isImportMenuExpanded {
                OutsideTapDismissOverlay {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isImportMenuExpanded = false
                    }
                }
                .transition(.opacity)
            }
        }
        .overlay(alignment: .top) {
            if isDirectionMenuExpanded {
                ChatDirectionMenu { direction in
                    viewModel.selectDirection(direction)
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isDirectionMenuExpanded = false
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .transition(
                    .opacity.combined(
                        with: .scale(scale: 0.96, anchor: .top)
                    )
                )
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.mediaAccessAlert)
        .animation(.easeInOut(duration: 0.2), value: isImportMenuExpanded)
        .animation(.easeInOut(duration: 0.2), value: isDirectionMenuExpanded)
        .onChange(of: viewModel.openSettingsEvent) { _, event in
            guard event != nil else { return }
            openURL(AppSettings.url)
            viewModel.consumeOpenSettingsEvent()
        }
        .onChange(of: isImportMenuExpanded) { _, isExpanded in
            guard isExpanded, isDirectionMenuExpanded else { return }
            withAnimation(.easeInOut(duration: 0.2)) {
                isDirectionMenuExpanded = false
            }
        }
        .onChange(of: isComposerFocused) { _, isFocused in
            guard isFocused, isDirectionMenuExpanded else { return }
            withAnimation(.easeInOut(duration: 0.2)) {
                isDirectionMenuExpanded = false
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .safeAreaInset(edge: .top, spacing: 0) {
            ChatNavigationBar(
                title: viewModel.title,
                subtitle: viewModel.subtitle,
                style: .aiChat,
                preset: viewModel.navigationLogoPreset,
                logoIcon: viewModel.navigationLogoIcon,
                onBack: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isDirectionMenuExpanded = false
                    }
                    dismiss()
                },
                onTitleTap: {
                    isComposerFocused = false
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isDirectionMenuExpanded.toggle()
                    }
                },
                onRegenerate: {
                    isComposerFocused = false
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isDirectionMenuExpanded = false
                    }
                    navigationPath.append(AppRoute.chatHistory)
                }
            )
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            composer
        }
        .photosPicker(
            isPresented: Binding(
                get: { viewModel.isPhotoPickerPresented },
                set: { if !$0 { viewModel.photoPickerDismissed() } }
            ),
            selection: $selectedPhotoItems,
            maxSelectionCount: max(1, viewModel.remainingAttachmentSlots),
            matching: .images
        )
        .onChange(of: selectedPhotoItems) { _, newItems in
            guard !newItems.isEmpty else { return }
            Task {
                await loadPhotos(from: newItems)
                selectedPhotoItems = []
            }
        }
        .fileImporter(
            isPresented: Binding(
                get: { viewModel.isFileImporterPresented },
                set: { if !$0 { viewModel.fileImporterDismissed() } }
            ),
            allowedContentTypes: [.image],
            allowsMultipleSelection: true
        ) { result in
            Task {
                await loadFiles(from: result)
            }
        }
    }

    @ViewBuilder
    private func mediaAccessAlert(for alert: ChatMediaAccessAlert) -> some View {
        switch alert {
        case .photoLibrary:
            PhotoAccessAlert(
                onCancel: viewModel.mediaAccessCancelled,
                onPrimary: viewModel.beginMediaAccessRequest
            )
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
            .scrollDismissesKeyboard(.interactively)
            .simultaneousGesture(
                DragGesture(minimumDistance: 8)
                    .onChanged { _ in
                        userInterruptedScroll = true
                    }
            )
            .onChange(of: viewModel.scrollPinToken) {
                userInterruptedScroll = false
                pinToPromptStart(using: proxy)
            }
        }
    }

    private var composer: some View {
        ComposerInput(
            mode: viewModel.composerMode,
            placeholder: viewModel.composerPlaceholder,
            autofocus: viewModel.showsEmptyState,
            attachments: viewModel.pendingAttachments.compactMap { attachment in
                guard let uiImage = UIImage(data: attachment.imageData) else { return nil }
                return ComposerAttachmentPreview(id: attachment.id, image: Image(uiImage: uiImage))
            },
            maxAttachments: ChatViewModel.maxAttachments,
            text: $viewModel.promptText,
            isFocused: $isComposerFocused,
            isImportMenuExpanded: $isImportMenuExpanded,
            onPhotos: { viewModel.importSourceSelected(.gallery) },
            onFiles: { viewModel.importSourceSelected(.files) },
            onRemoveAttachment: viewModel.removeAttachment,
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
        case let .user(id, text, _):
            UserPrompt(
                text: text,
                images: images(from: viewModel.imageData(for: message)),
                onCopy: { copyToPasteboard(viewModel.copyUserPromptTapped(id)) },
                onEdit: {
                    viewModel.editUserPromptTapped(id)
                    isComposerFocused = true
                }
            )
            .frame(maxWidth: .infinity, alignment: .trailing)

        case .generating:
            AIResponseIndicator()
                .frame(maxWidth: .infinity, alignment: .leading)

        case let .assistant(id, content):
            AIResponseBubble(
                content: content,
                isStreaming: viewModel.streamingAssistantID == id,
                onCopy: { copyToPasteboard(viewModel.copyResponseTapped(id)) },
                onRefresh: { viewModel.refreshResponseTapped(id) }
            )
            .frame(maxWidth: .infinity, alignment: .leading)

        case let .error(_, text):
            Text(text)
                .typography(style: .regular16)
                .foregroundStyle(.error)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func loadPhotos(from items: [PhotosPickerItem]) async {
        viewModel.beginAttachmentLoading()
        viewModel.photoPickerDismissed()

        var imageDataList: [Data] = []
        for item in items {
            guard let data = try? await item.loadTransferable(type: Data.self) else {
                continue
            }
            imageDataList.append(data)
        }

        viewModel.appendAttachments(imageDataList)
    }

    private func loadFiles(from result: Result<[URL], Error>) async {
        viewModel.fileImporterDismissed()

        guard case let .success(urls) = result else { return }

        viewModel.beginAttachmentLoading()

        var imageDataList: [Data] = []
        for url in urls.prefix(viewModel.remainingAttachmentSlots) {
            let accessed = url.startAccessingSecurityScopedResource()
            defer {
                if accessed {
                    url.stopAccessingSecurityScopedResource()
                }
            }

            guard let data = try? Data(contentsOf: url) else {
                continue
            }
            imageDataList.append(data)
        }

        viewModel.appendAttachments(imageDataList)
    }

    private func images(from dataList: [Data]) -> [Image] {
        dataList.compactMap { data in
            UIImage(data: data).map(Image.init(uiImage:))
        }
    }

    private func copyToPasteboard(_ string: String?) {
        guard let string else { return }
        UIPasteboard.general.string = string
    }

    private func pinToPromptStart(using proxy: ScrollViewProxy) {
        guard !userInterruptedScroll,
              let userID = viewModel.scrollPinUserMessageID
        else { return }

        withAnimation(.easeOut(duration: 0.25)) {
            proxy.scrollTo(userID, anchor: .top)
        }
    }
}

#Preview("Empty") {
    let container = ChatHistoryPreviewSupport.container()
    NavigationStack {
        ChatView(
            navigationPath: .constant(NavigationPath()),
            modelContext: container.mainContext
        )
    }
    .modelContainer(container)
}
