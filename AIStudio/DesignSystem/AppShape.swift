//
//  AppShape.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 04.07.2026.
//

import SwiftUI

enum AppShape {
    static let cornerRadius: CGFloat = 24

    static var card: RoundedRectangle {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
    }
}

#Preview {
    AppShape.card
        .fill(.card)
        .frame(width: 200, height: 100)
        .padding(24)
        .background(Color.background)
}
