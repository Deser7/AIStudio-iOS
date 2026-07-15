//
//  SelectionMenuOption.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

protocol SelectionMenuOption: Identifiable, Hashable {
    associatedtype TrailingContent: View = EmptyView

    var title: String { get }

    @ViewBuilder
    func trailingContent(isSelected: Bool) -> TrailingContent
}

extension SelectionMenuOption where TrailingContent == EmptyView {
    func trailingContent(isSelected: Bool) -> EmptyView {
        EmptyView()
    }
}
