//
//  AppNotificationContent.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 25.06.2026.
//

import Foundation

enum AppNotificationContent {
    case textCopied(message: String)
    case videoSaved(message: String)
    case fileTooLarge(title: String, subtitle: String)
}
