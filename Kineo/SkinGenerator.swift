//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SkinGenerator: NSObject {
    init(traitCollection: UITraitCollection = UITraitCollection()) {
        self.traitCollection = traitCollection
        super.init()
    }

    func skinsImage(from document: Document, currentPageIndex: Int) -> UIImage? {
        let minSkinPageIndex = max(currentPageIndex - SkinGenerator.skinPageCount, document.pages.startIndex)
        let skinPageRange = minSkinPageIndex..<currentPageIndex
        let skinPages = document.pages[skinPageRange]

        guard skinPages.count > 0 else { return nil }

        let opacityValues = Array(stride(from: SkinGenerator.maxOpacity, to: 0, by: SkinGenerator.opacityStep))
        let drawables = zip(opacityValues, skinPages.reversed())

        let size = CGSize(width: 512, height: 512)

        let format = UIGraphicsImageRendererFormat(for: traitCollection)
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            drawables.forEach { drawable in
                let (opacity, page) = drawable
                let drawing = page.drawing
                let image = drawing.image(from: drawing.bounds, scale: 1)
                image.draw(at: drawing.bounds.origin, blendMode: .normal, alpha: opacity)
            }
        }
    }

    func previewImage(from document: Document) -> UIImage? {
        let maxSkinPageIndex = max(SkinGenerator.skinPageCount, document.pages.endIndex)
        let skinPageRange = 0..<maxSkinPageIndex
        let skinPages = document.pages[skinPageRange]

        guard skinPages.count > 0 else { return nil }

        let opacityValues = Array(stride(from: 1, to: SkinGenerator.maxOpacity, by: SkinGenerator.opacityStep))
        let drawables = zip(opacityValues, skinPages)

        let size = CGSize(width: 512, height: 512)

        let format = UIGraphicsImageRendererFormat(for: traitCollection)
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            drawables.forEach { drawable in
                let (opacity, page) = drawable
                let drawing = page.drawing
                let image = drawing.image(from: drawing.bounds, scale: 1)
                image.draw(at: drawing.bounds.origin, blendMode: .normal, alpha: opacity)
            }
        }
    }

    var traitCollection: UITraitCollection

    // MARK: Boilerplate

    private static let skinPageCount = 4
    private static let maxOpacity = CGFloat(0.5)
    private static let opacityStep = CGFloat(-0.15)
}
