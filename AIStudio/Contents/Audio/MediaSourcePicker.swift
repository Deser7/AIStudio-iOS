//
//  MediaSourcePicker.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct MediaSourcePicker: View {
    let onSelect: (MediaSourceOption) -> Void

    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(.white.opacity(0.3))
                .frame(width: 36, height: 5)

            VStack(spacing: 12) {
                ForEach(MediaSourceOption.allCases) { option in
                    MediaSourceOptionRow(option: option) {
                        onSelect(option)
                    }
                }
            }
        }
        .frame(width: 358)
    }
}

#Preview {
    let sheetShape = RoundedRectangle(cornerRadius: 24, style: .continuous)

    ZStack(alignment: .bottom) {
        Color.background
            .ignoresSafeArea()

        MediaSourcePicker { _ in }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
            .background(Color.card, in: sheetShape)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
    }
}
