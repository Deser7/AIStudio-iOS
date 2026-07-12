//
//  Text+Localization.swift
//  AIStudio
//

import SwiftUI

extension Text {
    /// Localizes a String Catalog key. Missing keys render as-is (safe for dynamic text).
    init(key: String) {
        self.init(LocalizedStringKey(key))
    }
}
