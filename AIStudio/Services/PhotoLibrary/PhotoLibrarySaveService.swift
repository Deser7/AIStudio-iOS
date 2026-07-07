//
//  PhotoLibrarySaveService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import Photos

enum PhotoLibrarySaveError: Error {
    case assetCreationFailed
}

protocol PhotoLibraryVideoSaving: Sendable {
    @MainActor func saveVideo(at url: URL) async throws
}

final class PhotoLibrarySaveService: PhotoLibraryVideoSaving {
    nonisolated init() {}

    @MainActor
    func saveVideo(at url: URL) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            } completionHandler: { success, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if success {
                    continuation.resume()
                } else {
                    continuation.resume(throwing: PhotoLibrarySaveError.assetCreationFailed)
                }
            }
        }
    }
}
