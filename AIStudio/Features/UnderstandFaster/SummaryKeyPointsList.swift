//
//  SummaryKeyPointsList.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 08.08.2026.
//

import SwiftUI

struct SummaryKeyPointsList: View {
    let points: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(points.enumerated()), id: \.offset) { _, point in
                HStack(alignment: .top, spacing: 10) {
                    Circle()
                        .fill(Color.aiBlue)
                        .frame(width: 6, height: 6)
                        .padding(.top, 7)

                    Text(point)
                        .typography(style: .regular16)
                        .foregroundStyle(.white.opacity(0.85))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SummaryKeyPointsList(
        points: [
            "Following up on a previously sent document",
            "Asking if the recipient had time to review",
            "Requesting feedback and comments",
        ]
    )
    .padding(16)
    .background(Color.background)
    .preferredColorScheme(.dark)
}
