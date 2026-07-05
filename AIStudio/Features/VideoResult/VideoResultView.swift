//
//  VideoResultView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import SwiftUI

struct VideoResultView: View {
    @Binding var navigationPath: NavigationPath

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ChatNavigationBar(
                    title: "Result",
                    style: .centeredTitle,
                    onBack: popToTemplateDetail
                )

                ResultCard(
                    onReplace: regenerateVideo,
                    onPlay: {}
                )
                .padding(.horizontal, 8)

                Spacer(minLength: 16)

                actionButtons
                    .padding(.horizontal, 8)
                    .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var actionButtons: some View {
        HStack(spacing: 16) {
            SectionButton(title: "Share", style: .secondary) {}
            SectionButton(title: "Download", style: .primary) {}
        }
    }

    private func popToTemplateDetail() {
        guard navigationPath.count >= 2 else { return }
        navigationPath.removeLast(2)
    }

    private func regenerateVideo() {
        guard navigationPath.count >= 2 else { return }
        navigationPath.removeLast(2)
        navigationPath.append(AppRoute.videoGenerating)
    }
}

#Preview {
    NavigationStack {
        VideoResultView(navigationPath: .constant(NavigationPath()))
    }
}
