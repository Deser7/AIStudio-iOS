//
//  ChatImageEncoder.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 13.07.2026.
//

import UIKit

enum ChatImageEncoder {
    static let mimeType = "image/jpeg"

    static func jpegData(
        from imageData: Data,
        maxDimension: CGFloat = 1_536,
        quality: CGFloat = 0.8
    ) -> Data? {
        guard let image = UIImage(data: imageData) else { return nil }
        let scaled = scaledImage(image, maxDimension: maxDimension)
        return scaled.jpegData(compressionQuality: quality)
    }

    private static func scaledImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        let size = image.size
        let longest = max(size.width, size.height)
        guard longest > maxDimension, longest > 0 else { return image }

        let scale = maxDimension / longest
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
