//
//  Text+Localization.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import SwiftUI

extension Text {
    /// Localizes a String Catalog key. Missing keys render as-is (safe for dynamic text).
    init(key: String) {
        self.init(LocalizedStringKey(key))
    }
}
