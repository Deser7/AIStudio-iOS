//
//  VideoGeneratingView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import SwiftUI

struct VideoGeneratingView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack {
                ChatNavigationBar(
                    title: "",
                    style: .centeredTitle,
                    onBack: { dismiss() }
                )

                VStack {
                    generatingImage
                    statusTexts
                }

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var generatingImage: some View {
        GeneratingImageView()
            .padding(.horizontal, 16)
    }

    private var statusTexts: some View {
        VStack(spacing: 8) {
            Text("Generating...")
                .typography(style: .semiBold20)
                .foregroundStyle(.white)

            Text("We're creating the best result for you")
                .typography(style: .regular16)
                .foregroundStyle(.price)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationStack {
        VideoGeneratingView()
    }
}
