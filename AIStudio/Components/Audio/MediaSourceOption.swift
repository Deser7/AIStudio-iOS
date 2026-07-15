//
//  MediaSourceOption.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import Foundation

enum MediaSourceOption: CaseIterable, Sendable {
    case files
    case gallery

    var title: String {
        switch self {
        case .files: "Files"
        case .gallery: "Gallery"
        }
    }

    var subtitle: String {
        switch self {
        case .files: "Upload any file"
        case .gallery: "Select a photo or video from your gallery"
        }
    }
}
