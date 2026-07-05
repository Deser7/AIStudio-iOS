//
//  PhotoLibraryAccessService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Photos
import UIKit

final class PhotoLibraryAccessService: PhotoLibraryAccessProviding {
    var currentStatus: PhotoLibraryAuthorizationStatus {
        Self.map(PHPhotoLibrary.authorizationStatus(for: .readWrite))
    }

    func requestAccess() async -> PhotoLibraryAuthorizationStatus {
        await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                continuation.resume(returning: Self.map(status))
            }
        }
    }

    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

        Task { @MainActor in
            UIApplication.shared.open(url)
        }
    }

    private static func map(_ status: PHAuthorizationStatus) -> PhotoLibraryAuthorizationStatus {
        switch status {
        case .notDetermined:
            .notDetermined
        case .restricted:
            .restricted
        case .denied:
            .denied
        case .authorized:
            .authorized
        case .limited:
            .limited
        @unknown default:
            .denied
        }
    }
}
