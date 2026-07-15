//
//  ComposerImportMenu.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 13.07.2026.
//

import SwiftUI

struct ComposerImportMenu<MenuLabel: View>: View {
    @Binding var isExpanded: Bool
    let onPhotos: () -> Void
    let onFiles: () -> Void
    @ViewBuilder let label: () -> MenuLabel

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }
        } label: {
            label()
        }
        .buttonStyle(.plain)
    }
}

extension View {
    func composerImportPopover(
        isExpanded: Binding<Bool>,
        trailingInset: CGFloat,
        onGallery: @escaping () -> Void,
        onFiles: @escaping () -> Void
    ) -> some View {
        overlay(alignment: .bottomLeading) {
            if isExpanded.wrappedValue {
                VStack(spacing: 8) {
                    MediaSourceOptionRow(option: .gallery) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isExpanded.wrappedValue = false
                        }
                        onGallery()
                    }
                    MediaSourceOptionRow(option: .files) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isExpanded.wrappedValue = false
                        }
                        onFiles()
                    }
                }
                .padding(.trailing, trailingInset)
                .frame(maxWidth: .infinity, alignment: .leading)
                .alignmentGuide(.bottom) { dimensions in
                    dimensions[.top] - 8
                }
                .transition(
                    .opacity.combined(
                        with: .scale(scale: 0.96, anchor: .bottomLeading)
                    )
                )
            }
        }
        .zIndex(isExpanded.wrappedValue ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: isExpanded.wrappedValue)
    }
}

#Preview {
    ComposerImportMenuPreview()
}

private struct ComposerImportMenuPreview: View {
    @State private var isExpanded = true

    var body: some View {
        HStack(spacing: 16) {
            Text("Ask anything...")
                .foregroundStyle(.price)
                .frame(maxWidth: .infinity, alignment: .leading)

            ComposerImportMenu(
                isExpanded: $isExpanded,
                onPhotos: {},
                onFiles: {}
            ) {
                CircularIconButton(size: 40, icon: .photo)
            }

            CircularIconButton(size: 40, icon: .micro) {}
        }
        .composerImportPopover(
            isExpanded: $isExpanded,
            trailingInset: 96,
            onGallery: {},
            onFiles: {}
        )
        .padding(24)
        .background(Color.background)
    }
}
