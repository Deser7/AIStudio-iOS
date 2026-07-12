//
//  PhotoAccessAlert.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 05.07.2026.
//

import SwiftUI

struct PhotoAccessAlert: View {
    var title: String = "Allow access to photos?"
    var message: String = "To upload an image, the app needs access to your photo gallery."
    var primaryButtonTitle: String = "Allow"
    let onCancel: () -> Void
    let onPrimary: () -> Void
    
    private var alertShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                Text(key: title)
                    .font(.system(size: 17, weight: .semibold))
                    .tracking(-0.4)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Text(key: message)
                    .font(.system(size: 13, weight: .regular))
                    .tracking(-0.4)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            .padding(.top, 19)
            .padding(.bottom, 15)
            
            separator
                .frame(height: 1.33)

            HStack(spacing: 0) {
                alertButton(
                    title: "Cancel",
                    font: .system(size: 17, weight: .regular),
                    action: onCancel
                )

                separator
                    .frame(width: 1.33)

                alertButton(
                    title: primaryButtonTitle,
                    font: .system(size: 17, weight: .semibold),
                    action: onPrimary
                )
            }
            .frame(height: 44)
        }
        .frame(width: 270)
        .background { alertBackground }
        .clipShape(alertShape)
    }
    
    private var alertBackground: some View {
        ZStack {
            alertShape
                .fill(.regularMaterial)
            
            alertShape
                .fill(.alert.opacity(0.82))
        }
        .allowsHitTesting(false)
    }
    
    private var separator: some View {
        Rectangle()
            .fill(.separate.opacity(0.65))
    }
    
    private func alertButton(
        title: String,
        font: Font,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(key: title)
                .font(font)
                .tracking(-0.4)
                .lineSpacing(5)
                .foregroundStyle(.blue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        PhotoAccessAlert(onCancel: {}, onPrimary: {})
    }
}
