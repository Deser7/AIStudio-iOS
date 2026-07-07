//
//  VideoResultViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import Foundation
import Observation

enum VideoResultOverlay: Equatable {
    case none
    case saving
    case savedNotification
    case photoAccessSettings
}

@MainActor
@Observable
final class VideoResultViewModel {
    private(set) var overlay: VideoResultOverlay = .none
    var isShareSheetPresented = false

    let resultVideoURL: URL
    let savedNotificationMessage = "Video has been saved to your gallery"

    private let photoLibrary: PhotoLibraryAccessProviding
    private let videoSaver: PhotoLibraryVideoSaving
    private var notificationDismissTask: Task<Void, Never>?

    private let notificationAutoDismissNanoseconds: UInt64 = 2_500_000_000

    init(
        resultVideoURL: URL? = nil,
        photoLibrary: PhotoLibraryAccessProviding = PhotoLibraryAccessService(),
        videoSaver: PhotoLibraryVideoSaving = PhotoLibrarySaveService()
    ) {
        self.resultVideoURL = resultVideoURL ?? (try? ResultVideoStubProvider.videoURL()) ?? URL(fileURLWithPath: "/dev/null")
        self.photoLibrary = photoLibrary
        self.videoSaver = videoSaver
    }

    func downloadTapped() {
        guard overlay == .none else { return }

        Task {
            await performDownload()
        }
    }

    func shareTapped() {
        guard overlay == .none else { return }
        isShareSheetPresented = true
    }

    func dismissNotification() {
        notificationDismissTask?.cancel()
        notificationDismissTask = nil
        overlay = .none
    }

    func photoAccessSettingsCancelled() {
        overlay = .none
    }

    func openPhotoSettings() {
        photoLibrary.openSettings()
        overlay = .none
    }

    private func performDownload() async {
        let status = await resolvedPhotoAccessStatus()

        guard status.isGranted else {
            overlay = .photoAccessSettings
            return
        }

        overlay = .saving

        do {
            try await videoSaver.saveVideo(at: resultVideoURL)
            showSavedNotification()
        } catch {
            overlay = .none
        }
    }

    private func resolvedPhotoAccessStatus() async -> PhotoLibraryAuthorizationStatus {
        let status = photoLibrary.currentStatus

        guard status == .notDetermined else {
            return status
        }

        return await photoLibrary.requestAccess()
    }

    private func showSavedNotification() {
        overlay = .savedNotification

        notificationDismissTask?.cancel()
        notificationDismissTask = Task {
            try? await Task.sleep(nanoseconds: notificationAutoDismissNanoseconds)
            guard !Task.isCancelled else { return }
            dismissNotification()
        }
    }
}
