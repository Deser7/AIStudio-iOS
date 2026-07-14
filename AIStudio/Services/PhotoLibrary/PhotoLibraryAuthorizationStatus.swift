//
//  PhotoLibraryAuthorizationStatus.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//


enum PhotoLibraryAuthorizationStatus: Sendable {
    case notDetermined
    case denied
    case restricted
    case authorized
    case limited

    var isGranted: Bool {
        switch self {
        case .authorized, .limited:
            true
        case .notDetermined, .denied, .restricted:
            false
        }
    }
}

protocol PhotoLibraryAccessProviding: Sendable {
    @MainActor var currentStatus: PhotoLibraryAuthorizationStatus { get }
    @MainActor func requestAccess() async -> PhotoLibraryAuthorizationStatus
}
