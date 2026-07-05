//
//  GeneratingImageView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import SwiftUI

struct GeneratingImageView: View {
    private enum Layout {
        static let aspectRatio: CGFloat = 316 / 444
        static let cycleDuration: TimeInterval = 2.4
        static let scaleAmplitude: CGFloat = 0.035
        static let opacityAmplitude: CGFloat = 0.08
        static let animationMinimumInterval: TimeInterval = 1 / 60
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: Layout.animationMinimumInterval)) { timeline in
            Image("Generating")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale(at: timeline.date))
                .opacity(opacity(at: timeline.date))
                .frame(maxWidth: .infinity)
                .aspectRatio(Layout.aspectRatio, contentMode: .fit)
        }
    }

    private func phase(at date: Date) -> Double {
        let elapsed = date.timeIntervalSinceReferenceDate
        let progress = elapsed
            .truncatingRemainder(dividingBy: Layout.cycleDuration)
            / Layout.cycleDuration
        return progress * 2 * .pi
    }

    private func scale(at date: Date) -> CGFloat {
        1 + Layout.scaleAmplitude * sin(phase(at: date))
    }

    private func opacity(at date: Date) -> CGFloat {
        1 - Layout.opacityAmplitude + Layout.opacityAmplitude * sin(phase(at: date))
    }
}

#Preview {
    GeneratingImageView()
        .padding(.horizontal, 16)
        .background(Color.background)
}
