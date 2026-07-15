//
//  AddendumContent.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

enum AddendumContent {
    case add(() -> Void)
    case addLabel
    case loading
    case photo(Image, onClose: () -> Void)
}
