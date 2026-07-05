//
//  VideoTemplateDetailViewModel.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import Combine
import Foundation
import UIKit

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
final class VideoTemplateDetailViewModel: ObservableObject {
    let sectionTemplates: [VideoTemplate]

    @Published var selectedTemplateID: UUID
    @Published var aspectRatio: AspectRatio = .landscape16x9
    @Published var videoQuality: VideoQuality = .p1080
    @Published private(set) var photoState: VideoTemplatePhotoState = .none
    @Published private(set) var selectedPhoto: UIImage?
    @Published var expandedSetting: VideoTemplateExpandedSetting?

    var navigationTitle: String {
        selectedTemplate.title
    }

    var selectedTemplate: VideoTemplate {
        sectionTemplates.first { $0.id == selectedTemplateID }
            ?? sectionTemplates[0]
    }

    var isCreateEnabled: Bool {
        photoState == .loaded && selectedPhoto != nil
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

    func setPhoto(_ image: UIImage) {
        selectedPhoto = image
        photoState = .loaded
    }

    func resetPhoto() {
        selectedPhoto = nil
        photoState = .none
    }

    func createTapped() {
        guard isCreateEnabled else { return }
    }
}
