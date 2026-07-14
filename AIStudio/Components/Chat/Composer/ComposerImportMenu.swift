//
//  ComposerImportMenu.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 13.07.2026.
//

import SwiftUI

struct ComposerImportMenu<MenuLabel: View>: View {
    let onPhotos: () -> Void
    let onFiles: () -> Void
    @ViewBuilder let label: () -> MenuLabel

    var body: some View {
        Menu {
            // Bottom-anchored menus reverse item order; declare bottom→top.
            Button(action: onFiles) {
                Label {
                    Text(key: "Files")
                } icon: {
                    Image(systemName: "paperclip")
                }
            }
            Button(action: onPhotos) {
                Label {
                    Text(key: "Photos")
                } icon: {
                    Image(systemName: "photo.on.rectangle")
                }
            }
        } label: {
            label()
        }
    }
}

#Preview {
    ComposerImportMenu(
        onPhotos: {},
        onFiles: {}
    ) {
        CircularIconButton(size: 40, icon: .photo)
    }
    .padding(24)
    .background(Color.background)
}
