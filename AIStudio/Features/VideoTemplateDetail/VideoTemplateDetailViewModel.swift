//
//  VideoTemplateDetailViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Foundation
import Observation

enum VideoTemplateExpandedSetting: Equatable {
    case format
    case quality
}

enum VideoTemplatePhotoState: Equatable {
    case none
    case loading
    case loaded
}

@MainActor
@Observable
final class VideoTemplateDetailViewModel {
    let sectionTemplates: [VideoTemplate]

    var selectedTemplateID: UUID
    var aspectRatio: AspectRatio = .landscape16x9
    var videoQuality: VideoQuality = .p1080
    private(set) var photoState: VideoTemplatePhotoState = .none
    private(set) var selectedPhotoData: Data?
    var expandedSetting: VideoTemplateExpandedSetting?

    var navigationTitle: String {
        selectedTemplate.title
    }

    var selectedTemplate: VideoTemplate {
        sectionTemplates.first { $0.id == selectedTemplateID }
            ?? sectionTemplates[0]
    }

    var isCreateEnabled: Bool {
        photoState == .loaded && selectedPhotoData != nil
    }

    init(context: VideoTemplateDetailContext) {
        sectionTemplates = context.sectionTemplates
        selectedTemplateID = context.selectedTemplate.id
    }

    func toggleSetting(_ setting: VideoTemplateExpandedSetting) {
        if expandedSetting == setting {
            expandedSetting = nil
        } else {
            expandedSetting = setting
        }
    }

    func selectAspectRatio(_ ratio: AspectRatio) {
        aspectRatio = ratio
        expandedSetting = nil
    }

    func selectVideoQuality(_ quality: VideoQuality) {
        videoQuality = quality
        expandedSetting = nil
    }

    func beginPhotoLoading() {
        photoState = .loading
    }

    func setPhoto(_ data: Data) {
        selectedPhotoData = data
        photoState = .loaded
    }

    func resetPhoto() {
        selectedPhotoData = nil
        photoState = .none
    }
}
