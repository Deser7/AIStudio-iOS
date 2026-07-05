//
//  PhotoAccessAlert.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct PhotoAccessAlert: View {
    let onCancel: () -> Void
    let onAllow: () -> Void

    private var alertShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text("Allow access to photos?")
                        .typography(style: .semiBold20)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)

                    Text("To upload an image, the app needs access to your photo gallery.")
                        .typography(style: .regular16)
                        .foregroundStyle(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 16)

                Divider()
                    .overlay(Color.white.opacity(0.1))

                HStack(spacing: 0) {
                    alertButton(title: "Cancel", action: onCancel)

                    Divider()
                        .frame(width: 0.5)
                        .overlay(Color.white.opacity(0.1))

                    alertButton(title: "Allow", action: onAllow)
                }
                .frame(height: 44)
            }
            .background {
                CardBlurBackground(shape: alertShape, opacity: 0.9)
            }
            .clipShape(alertShape)
            .padding(.horizontal, 40)
        }
    }

    private func alertButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .typography(style: .regular16)
                .foregroundStyle(Color.aiBlue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        PhotoAccessAlert(onCancel: {}, onAllow: {})
    }
}
