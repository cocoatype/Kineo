//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import UIKit

public class SkinGenerator: NSObject {
    public init(traitCollection: UITraitCollection = UITraitCollection.current) {
        let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
        let finalTraitCollection = UITraitCollection(traitsFrom: [traitCollection, lightTraitCollection])
        self.traitCollection = finalTraitCollection
        super.init()
    }

    public func generateSkinsImage(from document: Document, currentPageIndex: Int) async -> (UIImage, Int) {
        let minSkinPageIndex = max(currentPageIndex - SkinGenerator.skinPageCount, document.pages.startIndex)
        let skinPageRange = minSkinPageIndex..<currentPageIndex
        let skinPages = document.pages[skinPageRange]
        let skinDrawings = skinPages.map { $0.drawing }
        let traitCollection = self.traitCollection
        let pageSize = CGSize(width: 512, height: 512)

        guard skinPages.count > 0 else { return (UIImage.emptyImage(withSize: pageSize), currentPageIndex) }

        let (images, _) = await DrawingImageGenerator.shared.generateSkinLayers(for: skinDrawings)
        let opacityValues = Array(stride(from: SkinGenerator.maxOpacity, to: 0, by: SkinGenerator.opacityStep))
        let drawables = zip(opacityValues, images.reversed())

        let format = UIGraphicsImageRendererFormat(for: traitCollection)

        let resultImage = UIGraphicsImageRenderer(size: pageSize, format: format).image { _ in
            drawables.forEach { drawable in
                let (opacity, image) = drawable
                traitCollection.performAsCurrent {
                    image.draw(at: .zero, blendMode: .normal, alpha: opacity)
                }
            }
        }
        return (resultImage, currentPageIndex)
    }

    

    public var traitCollection: UITraitCollection

    // MARK: Boilerplate

    private static let skinPageCount = 4
    private static let maxOpacity = CGFloat(0.5)
    private static let opacityStep = CGFloat(-0.15)
}
