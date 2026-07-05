//
//  GeneratingImageView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import SwiftUI

struct GeneratingImageView: View {

    var body: some View {
        TimelineView(.animation(minimumInterval: 1 / 60)) { timeline in
            Image("Generating")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale(at: timeline.date))
                .opacity(opacity(at: timeline.date))
                .frame(maxWidth: .infinity)
                .aspectRatio(316 / 444, contentMode: .fit)
        }
    }

    private func phase(at date: Date) -> Double {
        let elapsed = date.timeIntervalSinceReferenceDate
        let progress = elapsed.truncatingRemainder(dividingBy: 2.4) / 2.4
        return progress * 2 * .pi
    }

    private func scale(at date: Date) -> CGFloat {
        1 + 0.035 * sin(phase(at: date))
    }

    private func opacity(at date: Date) -> CGFloat {
        1 - 0.08 + 0.08 * sin(phase(at: date))
    }
}

#Preview {
    GeneratingImageView()
        .padding(.horizontal, 16)
        .background(Color.background)
}
