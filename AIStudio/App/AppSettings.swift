//
//  AppSettings.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 14.07.2026.
//

import UIKit

enum AppSettings {
    static var url: URL {
        URL(string: UIApplication.openSettingsURLString)!
    }
}
