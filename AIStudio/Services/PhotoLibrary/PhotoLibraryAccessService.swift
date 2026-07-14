//
//  PhotoLibraryAccessService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Photos

final class PhotoLibraryAccessService: PhotoLibraryAccessProviding {
    nonisolated init() {}

    @MainActor
    var currentStatus: PhotoLibraryAuthorizationStatus {
        Self.map(PHPhotoLibrary.authorizationStatus(for: .readWrite))
    }

    @MainActor
    func requestAccess() async -> PhotoLibraryAuthorizationStatus {
        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        return Self.map(status)
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
