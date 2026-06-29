//
//  AIResponseBubble.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 26.06.2026.
//

import SwiftUI

struct AIResponseBullet: Hashable, Sendable {
    let emphasis: String
    let text: String
}

struct AIResponseContent: Hashable, Sendable {
    let title: String
    let paragraphs: [String]
    let bullets: [AIResponseBullet]
    var closingParagraphs: [String] = []
}

struct AIResponseBubble: View {
    let content: AIResponseContent
    let onCopy: () -> Void
    let onRefresh: () -> Void

    @Environment(\.displayScale) private var displayScale

    private var iconStrokeWidth: CGFloat {
        (24 * 9 / 100).pixelAligned(to: displayScale)
    }

    private var dividerHeight: CGFloat {
        max(1, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }

    private var dividerColor: Color {
        Color(.divider)
            .opacity(0.1)
    }

    private var bubbleShape: AIResponseBubbleShape {
        AIResponseBubbleShape(
            cornerRadius: 24,
            bottomTrailingRadius: 4
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleView
            bodyView
            divider
            actionBar
        }
        .padding(16)
        .frame(width: 302, alignment: .leading)
        .background { bubbleBackground }
        .clipShape(bubbleShape)
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
            ForEach(content.paragraphs, id: \.self) { paragraph in
                bodyParagraph(paragraph)
            }

            ForEach(content.bullets, id: \.self) { bullet in
                bulletRow(bullet)
            }

            ForEach(content.closingParagraphs, id: \.self) { paragraph in
                bodyParagraph(paragraph)
            }
        }
    }

    private func bodyParagraph(_ text: String) -> some View {
        Text(text)
            .typography(style: .regular16)
            .foregroundStyle(bodyTextColor)
            .tracking(0)
            .lineSpacing(0)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func bulletRow(_ bullet: AIResponseBullet) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(bodyTextColor)
                .frame(width: 4, height: 4)
                .padding(.top, 6)

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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var divider: some View {
        Rectangle()
            .fill(dividerColor)
            .frame(maxWidth: .infinity)
            .frame(height: dividerHeight)
    }

    private var actionBar: some View {
        HStack {
            actionButton {
                CopyIcon()
                    .stroke(
                        .white,
                        style: StrokeStyle(
                            lineWidth: iconStrokeWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: 24, height: 24)
            } action: {
                onCopy()
            }

            Spacer(minLength: 0)

            actionButton {
                RefreshIcon()
                    .stroke(
                        .white,
                        style: StrokeStyle(
                            lineWidth: iconStrokeWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: 24, height: 24)
            } action: {
                onRefresh()
            }
        }
        .frame(height: 24)
        .opacity(0.5)
    }

    private func actionButton<Icon: View>(
        @ViewBuilder icon: () -> Icon,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            icon()
        }
        .buttonStyle(.plain)
        .appDisabledOpacity()
    }

    private var bubbleBackground: some View {
        GeometryReader { geo in
            BlurCardBackground(
                style: .compact,
                extent: geo.size.height,
                blurRadius: AppSurface.blurRadius,
                cardOpacity: 0.5,
                shape: bubbleShape
            )
        }
    }
}

private struct AIResponseBubbleShape: Shape {
    var cornerRadius: CGFloat
    var bottomTrailingRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        UnevenRoundedRectangle(
            topLeadingRadius: cornerRadius,
            bottomLeadingRadius: cornerRadius,
            bottomTrailingRadius: bottomTrailingRadius,
            topTrailingRadius: cornerRadius,
            style: .continuous
        ).path(in: rect)
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
