//
//  AddendumLoader.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 21.06.2026.
//

import SwiftUI

struct AddendumLoader: View {
    var size: CGFloat = Addendum.defaultSize

    var body: some View {
        Addendum(size: size, content: .loading)
    }
}

#Preview {
    AddendumLoader(size: Addendum.defaultSize)
        .padding(24)
        .background(Color.background)
}
