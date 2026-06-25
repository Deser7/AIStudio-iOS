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

/// Пузырь ответа AI с текстом и действиями (Figma «AI's response/Default»).
struct AIResponseBubble: View {
    let content: AIResponseContent
    var size: CGFloat
    let onCopy: () -> Void
    let onRefresh: () -> Void
    
    @Environment(\.displayScale) private var displayScale
    
    /// Figma ref width = 302. Базовая единица — 16px.
    private var spacing: CGFloat { size * 16 / 302 }
    private var fontSize: CGFloat { spacing }
    private var cornerRadius: CGFloat { spacing * 24 / 16 }
    private var iconSize: CGFloat { cornerRadius }
    private var bottomTrailingRadius: CGFloat { spacing * 4 / 16 }
    private var bulletSize: CGFloat { bottomTrailingRadius }
    private var bulletSpacing: CGFloat { spacing * 8 / 16 }
    private var bulletTopPadding: CGFloat { spacing * 6 / 16 }
    private var blurRadius: CGFloat { spacing * AppSurface.blurRadius / 16 }
    private var iconStrokeWidth: CGFloat {
        (iconSize * 9 / 100).pixelAligned(to: displayScale)
    }
    private var dividerHeight: CGFloat {
        max(spacing / 16, 1 / displayScale)
            .pixelAligned(to: displayScale)
    }
    private var dividerColor: Color {
        Color(.divider)
        .opacity(AppSurface.Interaction.faintOpacity)
    }
    
    private var bubbleShape: AIResponseBubbleShape {
        AIResponseBubbleShape(
            cornerRadius: cornerRadius,
            bottomTrailingRadius: bottomTrailingRadius
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            titleView
            bodyView
            divider
            actionBar
        }
        .padding(spacing)
        .frame(width: size, alignment: .leading)
        .background { bubbleBackground }
        .clipShape(bubbleShape)
    }
    
    private var bodyTextColor: Color {
        Color.accent.opacity(AppSurface.Interaction.responseBodyTextOpacity)
    }

    private var titleView: some View {
        Text(content.title)
            .font(AppFont.font(weight: .bold, size: fontSize))
            .foregroundStyle(AppGradient.main)
            .tracking(0)
            .lineSpacing(0)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var bodyView: some View {
        VStack(alignment: .leading, spacing: spacing) {
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
            .font(AppFont.font(weight: .regular, size: fontSize))
            .foregroundStyle(bodyTextColor)
            .tracking(0)
            .lineSpacing(0)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func bulletRow(_ bullet: AIResponseBullet) -> some View {
        HStack(alignment: .top, spacing: bulletSpacing) {
            Circle()
                .fill(bodyTextColor)
                .frame(width: bulletSize, height: bulletSize)
                .padding(.top, bulletTopPadding)

            Text(
                AppFont.emphasizedText(
                    bullet.emphasis,
                    suffix: bullet.text,
                    size: fontSize,
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
                        Color.accent,
                        style: StrokeStyle(
                            lineWidth: iconStrokeWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: iconSize, height: iconSize)
            } action: {
                onCopy()
            }
            
            Spacer(minLength: 0)
            
            actionButton {
                RefreshIcon()
                    .stroke(
                        Color.accent,
                        style: StrokeStyle(
                            lineWidth: iconStrokeWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .frame(width: iconSize, height: iconSize)
            } action: {
                onRefresh()
            }
        }
        .frame(height: iconSize)
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
                size: geo.size.height,
                blurRadius: blurRadius,
                cardOpacity: AppSurface.CardOpacity.responseBubble,
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
    let size: CGFloat = 302
    
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
        size: size,
        onCopy: {},
        onRefresh: {}
    )
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.background)
}
