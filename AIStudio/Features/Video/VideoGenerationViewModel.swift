//
//  VideoGenerationViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Combine
import Foundation

final class VideoGenerationViewModel: ObservableObject {
    let title = "AI Video"

    @Published var selectedSection: String
    @Published private(set) var isPhotoAccessAlertPresented = false
    @Published private(set) var pendingTemplate: VideoTemplate?

    let sectionNames: [String]

    private let sections: [VideoTemplateSection]
    private let photoLibrary: PhotoLibraryAccessProviding

    var templates: [VideoTemplate] {
        sections.first { $0.name == selectedSection }?.templates ?? []
    }

    init(
        sections: [VideoTemplateSection] = VideoTemplateStub.sections,
        photoLibrary: PhotoLibraryAccessProviding = PhotoLibraryAccessService()
    ) {
        self.sections = sections
        self.photoLibrary = photoLibrary
        sectionNames = sections.map(\.name)
        selectedSection = sections.first?.name ?? ""
    }

    func templateTapped(_ template: VideoTemplate) {
        if photoLibrary.currentStatus.isGranted {
            startGeneration(with: template)
            return
        }

        pendingTemplate = template
        isPhotoAccessAlertPresented = true
    }

    func photoAccessCancelled() {
        isPhotoAccessAlertPresented = false
        pendingTemplate = nil
    }

    func photoAccessAllowed() async {
        let currentStatus = photoLibrary.currentStatus

        switch currentStatus {
        case .notDetermined:
            let status = await photoLibrary.requestAccess()
            await MainActor.run {
                isPhotoAccessAlertPresented = false

                if status.isGranted, let template = pendingTemplate {
                    startGeneration(with: template)
                }

                pendingTemplate = nil
            }

        case .denied, .restricted:
            await MainActor.run {
                isPhotoAccessAlertPresented = false
                pendingTemplate = nil
            }
            photoLibrary.openSettings()

        case .authorized, .limited:
            await MainActor.run {
                isPhotoAccessAlertPresented = false

                if let template = pendingTemplate {
                    startGeneration(with: template)
                }

                pendingTemplate = nil
            }
        }
    }

    func isSelected(_ template: VideoTemplate) -> Bool {
        pendingTemplate?.id == template.id && isPhotoAccessAlertPresented
    }

    private func startGeneration(with template: VideoTemplate) {
        _ = template
    }
}
