//
//  LanguageStore.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation
import Observation

enum AppLanguage: String, CaseIterable, Identifiable, Hashable, Sendable {
    case english = "en"
    case russian = "ru"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .english: "English"
        case .russian: "Russian"
        }
    }

    var locale: Locale {
        Locale(identifier: rawValue)
    }
}

extension AppLanguage: SelectionMenuOption {}

@Observable
@MainActor
final class LanguageStore {
    static let shared = LanguageStore()

    /// Snapshot for non-UI callers (e.g. `APIError`) without hopping to MainActor.
    nonisolated(unsafe) private(set) static var resolvedLocale = Locale(identifier: "en")

    private static let storageKey = "app.language"

    var preference: AppLanguage {
        didSet {
            UserDefaults.standard.set(preference.rawValue, forKey: Self.storageKey)
            Self.resolvedLocale = preference.locale
        }
    }

    var locale: Locale { preference.locale }

    init() {
        if let raw = UserDefaults.standard.string(forKey: Self.storageKey),
           let stored = AppLanguage(rawValue: raw) {
            preference = stored
        } else {
            preference = Self.defaultLanguage
        }
        Self.resolvedLocale = preference.locale
    }

    /// First launch (or after removing System): follow device if RU, otherwise English.
    private static var defaultLanguage: AppLanguage {
        Locale.current.language.languageCode?.identifier == "ru" ? .russian : .english
    }
}

enum L10n {
    static func string(_ key: String.LocalizationValue) -> String {
        String(localized: key, locale: LanguageStore.resolvedLocale)
    }
}
