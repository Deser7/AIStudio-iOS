//
//  CameraAccessService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 13.07.2026.
//

import AVFoundation
import UIKit

enum CameraAuthorizationStatus: Sendable {
    case notDetermined
    case denied
    case restricted
    case authorized

    var isGranted: Bool {
        self == .authorized
    }
}

protocol CameraAccessProviding: Sendable {
    @MainActor var currentStatus: CameraAuthorizationStatus { get }
    @MainActor var isCameraAvailable: Bool { get }
    @MainActor func requestAccess() async -> CameraAuthorizationStatus
    @MainActor func openSettings()
}

final class CameraAccessService: CameraAccessProviding {
    nonisolated init() {}

    @MainActor
    var currentStatus: CameraAuthorizationStatus {
        Self.map(AVCaptureDevice.authorizationStatus(for: .video))
    }

    @MainActor
    var isCameraAvailable: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    @MainActor
    func requestAccess() async -> CameraAuthorizationStatus {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        return granted ? .authorized : .denied
    }

    @MainActor
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    private static func map(_ status: AVAuthorizationStatus) -> CameraAuthorizationStatus {
        switch status {
        case .notDetermined:
            .notDetermined
        case .restricted:
            .restricted
        case .denied:
            .denied
        case .authorized:
            .authorized
        @unknown default:
            .denied
        }
    }
}
