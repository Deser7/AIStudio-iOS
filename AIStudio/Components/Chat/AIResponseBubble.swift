//
//  AIResponseBubble.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct AIResponseBubble: View {
    let content: AIResponseContent
    var isStreaming: Bool = false
    let onCopy: () -> Void
    let onRefresh: () -> Void

    @State private var showsCopyConfirmation = false
    @State private var copyConfirmationResetTask: Task<Void, Never>?

    private var actionIconStrokeStyle: StrokeStyle {
        StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !content.title.isEmpty {
                titleView
            }
            bodyView
            divider
            actionBar
        }
        .padding(16)
        .frame(width: 302, alignment: .leading)
        .background(CardBlurBackground(opacity: 0.5))
        .onDisappear {
            copyConfirmationResetTask?.cancel()
        }
    }

    private var bodyTextColor: Color {
        .white.opacity(0.8)
    }

    private var titleView: some View {
        Text(content.title)
            .typography(style: .bold16)
            .foregroundStyle(AppGradient.main)
            .tracking(0)
            .lineSpacing(0)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var bodyView: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Index identity keeps @State alive while streaming text grows.
            ForEach(Array(content.paragraphs.enumerated()), id: \.offset) { _, paragraph in
                FadingStreamingParagraph(
                    text: paragraph,
                    isStreaming: isStreaming,
                    color: bodyTextColor
                )
            }

            ForEach(content.bullets, id: \.self) { bullet in
                bulletRow(bullet)
            }

            ForEach(Array(content.closingParagraphs.enumerated()), id: \.offset) { index, paragraph in
                FadingStreamingParagraph(
                    text: paragraph,
                    isStreaming: false,
                    color: bodyTextColor
                )
                .id("closing-\(index)")
            }
        }
    }

    private func bulletRow(_ bullet: AIResponseBullet) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(bodyTextColor)
                .frame(width: 4, height: 4)
                .padding(.top, 6)

            Group {
                if isStreaming {
                    Text(
                        Typography.emphasizedText(
                            bullet.emphasis,
                            suffix: bullet.text,
                            style: .regular16,
                            color: bodyTextColor
                        )
                    )
                    .tracking(0)
                    .lineSpacing(0)
                    .multilineTextAlignment(.leading)
                } else {
                    SelectableText(
                        attributedText: Typography.emphasizedAttributedString(
                            bullet.emphasis,
                            suffix: bullet.text,
                            style: .regular16,
                            color: bodyTextColor
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var divider: some View {
        Rectangle()
            .fill(.white.opacity(0.1))
            .frame(maxWidth: .infinity)
            .frame(height: 1)
    }

    private var actionBar: some View {
        HStack {
            actionButton {
                copyActionIcon
            } action: {
                onCopy()
                confirmCopy()
            }

            Spacer(minLength: 0)

            actionButton {
                RefreshIcon()
                    .stroke(.white, style: actionIconStrokeStyle)
                    .frame(width: 24, height: 24)
            } action: {
                onRefresh()
            }
        }
        .frame(height: 24)
        .opacity(0.5)
    }

    @ViewBuilder
    private var copyActionIcon: some View {
        ZStack {
            if showsCopyConfirmation {
                CheckIcon()
                    .fill(.white)
                    .transition(.scale(scale: 0.6).combined(with: .opacity))
            } else {
                CopyIcon()
                    .stroke(.white, style: actionIconStrokeStyle)
                    .transition(.scale(scale: 0.6).combined(with: .opacity))
            }
        }
        .frame(width: 24, height: 24)
    }

    private func actionButton<Icon: View>(
        @ViewBuilder icon: () -> Icon,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            icon()
        }
        .buttonStyle(.plain)
    }

    private func confirmCopy() {
        copyConfirmationResetTask?.cancel()

        withAnimation(.spring(response: 0.28, dampingFraction: 0.72)) {
            showsCopyConfirmation = true
        }

        copyConfirmationResetTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1.5))
            guard !Task.isCancelled else { return }

            withAnimation(.spring(response: 0.28, dampingFraction: 0.72)) {
                showsCopyConfirmation = false
            }
        }
    }
}

#Preview {
    AIResponseBubble(
        content: AIResponseContent(
            title: "Welcome to the team, Alexander!",
            paragraphs: [
                """
                Hi Alexander, welcome to the development team! We're all really \
                looking forward to having you start next week, and we're confident \
                you'll settle in quickly.
                """,
                "Here are a few tips to help you get through your first week:"
            ],
            bullets: [
                AIResponseBullet(
                    emphasis: "Focus on getting up to speed",
                    text: """
                    don't hesitate to ask questions if anything is unclear. We're used \
                    to helping new team members find their feet.
                    """
                ),
                AIResponseBullet(
                    emphasis: "Meet the team",
                    text: """
                    we're having a short welcome meeting on Monday at 11:00 AM. It'll \
                    be a great chance to connect with everyone.
                    """
                ),
                AIResponseBullet(
                    emphasis: "Documentation",
                    text: """
                    all the key materials are available in our internal knowledge base. \
                    I'll send you the link separately.
                    """
                )
            ],
            closingParagraphs: [
                """
                If you need help setting up your development environment or have any \
                questions about the projects, feel free to reach out to me or the tech lead.
                """,
                "Looking forward to working with you!",
                "Best,",
                "[Your Name]",
                "Team Lead"
            ]
        ),
        onCopy: {},
        onRefresh: {}
    )
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.background)
}

#Preview("Streaming fade") {
    AIResponseBubble(
        content: AIResponseContent(
            title: "",
            paragraphs: ["Soft fade appears on each new chunk of the reply."],
            bullets: []
        ),
        isStreaming: true,
        onCopy: {},
        onRefresh: {}
    )
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.background)
}
