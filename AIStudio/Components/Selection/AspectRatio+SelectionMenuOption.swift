//
//  AspectRatio+SelectionMenuOption.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

extension AspectRatio: Identifiable, SelectionMenuOption {
    var id: Self { self }

    func trailingContent(isSelected: Bool) -> AspectRatioIcon {
        AspectRatioIcon(ratio: self, isSelected: isSelected)
    }
}
