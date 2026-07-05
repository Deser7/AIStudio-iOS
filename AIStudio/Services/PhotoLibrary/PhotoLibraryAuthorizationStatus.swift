//
//  PhotoLibraryAuthorizationStatus.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation

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
    var currentStatus: PhotoLibraryAuthorizationStatus { get }
    func requestAccess() async -> PhotoLibraryAuthorizationStatus
    func openSettings()
}
