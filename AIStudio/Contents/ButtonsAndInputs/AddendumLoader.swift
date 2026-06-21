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

#Preview("Addendum — loading") {
    VStack(spacing: 24) {
        AddendumLoader()

        AddendumLoader(size: 200)
    }
    .padding(24)
    .background(Color.background)
}

#Preview("Addendum — loading scaled") {
    GeometryReader { geo in
        let size = geo.size.width * 0.25

        AddendumLoader(size: size)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
    }
}
