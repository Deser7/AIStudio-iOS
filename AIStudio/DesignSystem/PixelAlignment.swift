//
//  PixelAlignment.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 23.06.2026.
//

import CoreGraphics

extension CGFloat {
    func pixelAligned(to displayScale: CGFloat) -> CGFloat {
        (self * displayScale).rounded() / displayScale
    }
}
