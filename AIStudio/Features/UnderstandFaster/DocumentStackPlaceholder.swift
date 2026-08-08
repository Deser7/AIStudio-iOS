//
//  DocumentStackPlaceholder.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 08.08.2026.
//

import SwiftUI

struct DocumentStackPlaceholder: View {
    var body: some View {
        ZStack {
            documentCard
                .offset(x: -18, y: 10)
                .opacity(0.55)
            documentCard
                .offset(x: 18, y: 6)
                .opacity(0.75)
            documentCard
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .accessibilityHidden(true)
    }

    private var documentCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<4, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(.summaryBadge.opacity(index == 0 ? 0.35 : 0.2))
                    .frame(height: 6)
                    .frame(maxWidth: index == 3 ? 70 : .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .frame(width: 120, height: 150)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(alignment: .topTrailing) {
            DocumentIcon()
                .fill(.summaryBadge.opacity(0.4))
                .frame(width: 18, height: 18)
                .padding(10)
        }
        .shadow(color: .black.opacity(0.25), radius: 8, y: 4)
    }
}

#Preview {
    DocumentStackPlaceholder()
        .frame(height: 180)
        .padding(16)
        .background(Color.background)
        .preferredColorScheme(.dark)
}
