//
//  VideoGenerationViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation
import Observation

@Observable
final class VideoGenerationViewModel {
    let title = "AI Video"

    var selectedSection: String
    private(set) var isPhotoAccessAlertPresented = false
    private(set) var pendingTemplate: VideoTemplate?
    private(set) var detailContextToOpen: VideoTemplateDetailContext?

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

    @MainActor
    @discardableResult
    func templateTapped(_ template: VideoTemplate) -> VideoTemplateDetailContext? {
        if photoLibrary.currentStatus.isGranted {
            return detailContext(for: template)
        }

        pendingTemplate = template
        isPhotoAccessAlertPresented = true
        return nil
    }

    @MainActor
    func photoAccessCancelled() {
        isPhotoAccessAlertPresented = false
        pendingTemplate = nil
    }

    @MainActor
    func beginPhotoAccessRequest() {
        Task {
            let context = await photoAccessAllowed()
            isPhotoAccessAlertPresented = false
            detailContextToOpen = context
        }
    }

    @MainActor
    func consumeDetailContextToOpen() {
        detailContextToOpen = nil
    }

    @MainActor
    func isSelected(_ template: VideoTemplate) -> Bool {
        pendingTemplate?.id == template.id && isPhotoAccessAlertPresented
    }

    @MainActor
    private func photoAccessAllowed() async -> VideoTemplateDetailContext? {
        guard let template = pendingTemplate else { return nil }

        let currentStatus = photoLibrary.currentStatus

        switch currentStatus {
        case .notDetermined:
            let status = await photoLibrary.requestAccess()
            pendingTemplate = nil

            guard status.isGranted else { return nil }
            return detailContext(for: template)

        case .denied, .restricted:
            pendingTemplate = nil
            photoLibrary.openSettings()
            return nil

        case .authorized, .limited:
            pendingTemplate = nil
            return detailContext(for: template)
        }
    }

    private func detailContext(for template: VideoTemplate) -> VideoTemplateDetailContext {
        VideoTemplateDetailContext(
            selectedTemplate: template,
            sectionTemplates: templates
        )
    }
}
