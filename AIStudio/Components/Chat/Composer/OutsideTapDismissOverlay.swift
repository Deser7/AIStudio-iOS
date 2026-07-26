//
//  OutsideTapDismissOverlay.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 13.07.2026.
//

import SwiftUI

struct OutsideTapDismissOverlay: View {
    let onDismiss: () -> Void

    var body: some View {
        Color.clear
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .onTapGesture(perform: onDismiss)
    }
}

#Preview {
    OutsideTapDismissOverlay(onDismiss: {})
        .background(Color.background)
}
