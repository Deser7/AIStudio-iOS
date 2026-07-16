//
//  AiChatRow.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 17.07.2026.
//

import SwiftUI

struct AiChatRow<Icon: View>: View {
    let title: String
    let subtitle: String
    var viewsText: String? = nil
    var author: String? = nil
    let action: () -> Void
    @ViewBuilder var icon: () -> Icon

    var body: some View {
        Button(action: action) {
            HStack(spacing: 24) {
                icon()
                    .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .typography(style: .semiBold16)
                        .foregroundStyle(.white)
                        .tracking(0)
                        .lineLimit(1)

                    Text(subtitle)
                        .typography(style: .regular12)
                        .foregroundStyle(.white.opacity(0.5))
                        .tracking(0)
                        .lineLimit(1)

                    if hasMetadata {
                        metadataRow
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(width: 24, height: 24)
            }
            .padding(.leading, 24)
            .padding(.trailing, 16)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, minHeight: 72, alignment: .leading)
            .background(CardBlurBackground(shape: Rectangle(), opacity: 0.4))
        }
        .buttonStyle(.plain)
    }

    private var hasMetadata: Bool {
        viewsText != nil || author != nil
    }

    private var metadataRow: some View {
        HStack(spacing: 6) {
            if let viewsText {
                HStack(spacing: 4) {
                    DesignerIcon()
                        .fill(.white.opacity(0.5))
                        .frame(width: 12, height: 12)

                    Text(viewsText)
                        .typography(style: .regular12)
                        .foregroundStyle(.white.opacity(0.5))
                        .tracking(0)
                        .lineLimit(1)
                }
            }

            if viewsText != nil, author != nil {
                Text("•")
                    .typography(style: .regular12)
                    .foregroundStyle(.white.opacity(0.5))
            }

            if let author {
                Text(author)
                    .typography(style: .regular12)
                    .foregroundStyle(.white.opacity(0.5))
                    .tracking(0)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        AiChatRow(
            title: "General AI",
            subtitle: "Your default AI assistant",
            viewsText: "352.1K",
            author: "@Kraze_12",
            action: {}
        ) {
            ZStack {
                AppGradient.blue
                    .clipShape(Circle())

                GenerateIcon()
                    .fill(.white)
                    .frame(width: 24, height: 24)
            }
        }

        AiChatRow(
            title: "General AI",
            subtitle: "Your default AI assistant",
            viewsText: "352.1K",
            author: "@Kraze_12",
            action: {}
        ) {
            ZStack {
                AppGradient.blue
                    .clipShape(Circle())

                GenerateIcon()
                    .fill(.white)
                    .frame(width: 24, height: 24)
            }
        }

        AiChatRow(
            title: "General AI",
            subtitle: "Your default AI assistant",
            action: {}
        ) {
            ZStack {
                AppGradient.blue
                    .clipShape(Circle())

                GenerateIcon()
                    .fill(.white)
                    .frame(width: 24, height: 24)
            }
        }
    }
    .clipShape(AppShape.card)
    .padding(24)
    .background(Color.background)
}
