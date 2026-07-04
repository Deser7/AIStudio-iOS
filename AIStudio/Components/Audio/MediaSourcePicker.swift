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
        VStack(spacing: 0) {
            Capsule()
                .fill(.white.opacity(0.15))
                .frame(width: 36, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 16)

            VStack(spacing: 12) {
                ForEach(MediaSourceOption.allCases) { option in
                    MediaSourceOptionRow(option: option) {
                        onSelect(option)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        MediaSourcePicker { _ in }
            .background(Color.background)
    }
}
