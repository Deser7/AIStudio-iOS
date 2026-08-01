//
//  ChatViewModel+Attachments.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

extension ChatViewModel {
    func importSourceSelected(_ source: ChatImportSource) {
        guard remainingAttachmentSlots > 0, !isGenerating else { return }
        switch source {
        case .gallery:
            beginGalleryImport()
        case .files:
            isFileImporterPresented = true
        }
    }

    func mediaAccessCancelled() {
        mediaAccessAlert = nil
        pendingImportSource = nil
    }

    func consumeOpenSettingsEvent() {
        openSettingsEvent = nil
    }

    func beginMediaAccessRequest() {
        if mediaAccessAlert == .microphone {
            Task { await resolveMicrophoneAccess() }
            return
        }

        guard let source = pendingImportSource else {
            mediaAccessAlert = nil
            return
        }

        Task {
            switch source {
            case .gallery:
                await resolveGalleryAccess()
            case .files:
                mediaAccessAlert = nil
                pendingImportSource = nil
            }
        }
    }

    func photoPickerDismissed() {
        isPhotoPickerPresented = false
    }

    func fileImporterDismissed() {
        isFileImporterPresented = false
    }

    func beginAttachmentLoading() {
        isAttachmentLoading = true
    }

    func finishAttachmentLoading() {
        isAttachmentLoading = false
    }

    func appendAttachments(_ imageDataList: [Data]) {
        let slots = remainingAttachmentSlots
        guard slots > 0 else {
            isAttachmentLoading = false
            return
        }

        let limited = imageDataList.prefix(slots).compactMap { data -> PendingChatAttachment? in
            guard let jpegData = ChatImageEncoder.jpegData(from: data) else { return nil }
            return PendingChatAttachment(id: UUID(), imageData: jpegData, existingFileName: nil)
        }
        pendingAttachments.append(contentsOf: limited)
        isAttachmentLoading = false
    }

    func removeAttachment(_ id: UUID) {
        pendingAttachments.removeAll { $0.id == id }
    }

    func beginGalleryImport() {
        if photoLibrary.currentStatus.isGranted {
            isPhotoPickerPresented = true
            return
        }
        pendingImportSource = .gallery
        mediaAccessAlert = .photoLibrary
    }

    func resolveGalleryAccess() async {
        let currentStatus = photoLibrary.currentStatus

        switch currentStatus {
        case .notDetermined:
            let status = await photoLibrary.requestAccess()
            mediaAccessAlert = nil
            pendingImportSource = nil
            guard status.isGranted else { return }
            isPhotoPickerPresented = true

        case .denied, .restricted:
            mediaAccessAlert = nil
            pendingImportSource = nil
            openSettingsEvent = UUID()

        case .authorized, .limited:
            mediaAccessAlert = nil
            pendingImportSource = nil
            isPhotoPickerPresented = true
        }
    }

    func persistAttachments(_ attachments: [PendingChatAttachment]) -> [String] {
        attachments.compactMap { attachment in
            if let existing = attachment.existingFileName {
                return existing
            }
            return try? ChatImageStore.saveJPEG(sessionID: sessionID, data: attachment.imageData)
        }
    }
}
