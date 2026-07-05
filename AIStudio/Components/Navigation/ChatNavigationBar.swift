//
//  ChatNavigationBar.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 24.06.2026.
//

import SwiftUI

enum ChatNavigationBarStyle {
    case aiChat
    case aiVideo
    case centeredTitle
}

struct ChatNavigationBar: View {
    let title: String
    var subtitle: String = ""
    var style: ChatNavigationBarStyle = .aiChat
    var preset = AppGradient.Preset.blue
    let onBack: () -> Void
    var onRegenerate: (() -> Void)?
    
    private var showsRegenerateButton: Bool {
        style != .centeredTitle && onRegenerate != nil
    }
    
    var body: some View {
        barContent
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 75)
            .background {
                if style != .centeredTitle {
                    CardBlurBackground(shape: Rectangle(), opacity: 0.4)
                        .ignoresSafeArea(edges: .top)
                }
            }
    }
    
    @ViewBuilder
    private var barContent: some View {
        switch style {
        case .centeredTitle:
            centeredContent
        case .aiChat, .aiVideo:
            leadingContent
        }
    }
    
    private var leadingContent: some View {
        HStack(spacing: 10) {
            backButton
            
            HStack(spacing: 10) {
                leadingIcon
                
                titleSection
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer(minLength: 10)
            
            if showsRegenerateButton {
                regenerateButton
            }
        }
    }
    
    private var centeredContent: some View {
        ZStack {
            HStack {
                backButton
                
                Spacer(minLength: 0)
                
                Color.clear
                    .frame(width: 44, height: 44)
            }
            
            Text(title)
                .typography(style: .semiBold20)
                .foregroundStyle(.white)
                .lineLimit(1)
        }
    }
    
    @ViewBuilder
    private var leadingIcon: some View {
        switch style {
        case .aiChat:
            Logo(size: 32, preset: preset, icon: .generate)
        case .aiVideo:
            Logo(size: 32, preset: preset, icon: .magic)
        case .centeredTitle:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var titleSection: some View {
        switch style {
        case .aiChat:
            OnboardingTitleSection(
                title: title,
                subtitle: subtitle,
                style: .navigation
            )
        case .aiVideo:
            Text(title)
                .typography(style: .semiBold20)
                .foregroundStyle(.white)
                .lineLimit(1)
        case .centeredTitle:
            EmptyView()
        }
    }
    
    private var backButton: some View {
        Button(action: onBack) {
            Image(systemName: "chevron.left")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44, alignment: .leading)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Back"))
    }
    
    private var regenerateButton: some View {
        Button(action: { onRegenerate?() }) {
            RegenerateIcon()
                .fill(.white)
                .frame(width: 24, height: 24)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text("Regenerate"))
    }
}

#Preview("AI Chat") {
    ZStack {
        AppGradient.background.ignoresSafeArea()
        VStack(spacing: 0) {
            ChatNavigationBar(
                title: "AI Chat",
                subtitle: "26.03.2026",
                style: .aiChat,
                preset: .main,
                onBack: {},
                onRegenerate: {}
            )
            Spacer()
        }
    }
}

#Preview("AI ChatBlue") {
    ZStack {
        AppGradient.background.ignoresSafeArea()
        VStack(spacing: 0) {
            ChatNavigationBar(
                title: "AI Chat",
                subtitle: "26.03.2026",
                style: .aiChat,
                preset: .blue,
                onBack: {},
                onRegenerate: {}
            )
            Spacer()
        }
    }
}

#Preview("AI Video") {
    ZStack {
        AppGradient.background.ignoresSafeArea()
        VStack(spacing: 0) {
            ChatNavigationBar(
                title: "AI Video",
                style: .aiVideo,
                preset: .main,
                onBack: {},
                onRegenerate: {}
            )
            Spacer()
        }
    }
}

#Preview("Settings") {
    ZStack {
        AppGradient.background.ignoresSafeArea()
        VStack(spacing: 0) {
            ChatNavigationBar(
                title: "Settings",
                style: .centeredTitle,
                onBack: {}
            )
            Spacer()
        }
    }
}

#Preview("Clay Fool") {
    ZStack {
        AppGradient.background.ignoresSafeArea()
        VStack(spacing: 0) {
            ChatNavigationBar(
                title: "Clay Fool",
                style: .centeredTitle,
                onBack: {}
            )
            Spacer()
        }
    }
}
