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

    let sectionNames: [String]

    private let sections: [VideoTemplateSection]

    var templates: [VideoTemplate] {
        sections.first { $0.name == selectedSection }?.templates ?? []
    }

    init(sections: [VideoTemplateSection] = VideoTemplateStub.sections) {
        self.sections = sections
        sectionNames = sections.map(\.name)
        selectedSection = sections.first?.name ?? ""
    }

    func templateTapped(_ template: VideoTemplate) {}
}
