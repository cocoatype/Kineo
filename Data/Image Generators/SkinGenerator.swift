//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public class SkinGenerator: NSObject {
    public init(traitCollection: UITraitCollection = UITraitCollection.current) {
        let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
        let finalTraitCollection = UITraitCollection(traitsFrom: [traitCollection, lightTraitCollection])
        self.traitCollection = finalTraitCollection
        super.init()
    }

    public func generateSkinsImage(from document: Document, currentPageIndex: Int, completionHandler: @escaping ((UIImage?, Int) -> Void)) {
        let minSkinPageIndex = max(currentPageIndex - SkinGenerator.skinPageCount, document.pages.startIndex)
        let skinPageRange = minSkinPageIndex..<currentPageIndex
        let skinPages = document.pages[skinPageRange]
        let skinDrawings = skinPages.map { $0.drawing }
        let traitCollection = self.traitCollection

        guard skinPages.count > 0 else { return completionHandler(nil, currentPageIndex) }

        DrawingImageGenerator.shared.generateSkinLayers(for: skinDrawings) { images, _ in
            let opacityValues = Array(stride(from: SkinGenerator.maxOpacity, to: 0, by: SkinGenerator.opacityStep))
            let drawables = zip(opacityValues, images.reversed())

            let size = CGSize(width: 512, height: 512)
            let format = UIGraphicsImageRendererFormat(for: traitCollection)

            let resultImage = UIGraphicsImageRenderer(size: size, format: format).image { _ in
                drawables.forEach { drawable in
                    let (opacity, image) = drawable
                    traitCollection.performAsCurrent {
                        image.draw(at: .zero, blendMode: .normal, alpha: opacity)
                    }
                }
            }
            completionHandler(resultImage, currentPageIndex)
        }
    }

    public func generatePreviewImage(from document: Document, withBackground: Bool = false, completionHandler: @escaping ((UIImage?) -> Void)) {
        let maxSkinPageIndex = min(SkinGenerator.skinPageCount, document.pages.endIndex)
        let skinPageRange = 0..<maxSkinPageIndex
        let skinPages = document.pages[skinPageRange]
        let skinDrawings = skinPages.map { $0.drawing }
        let traitCollection = self.traitCollection

        guard skinPages.count > 0 else { return completionHandler(nil) }

        DrawingImageGenerator.shared.generateSkinLayers(for: skinDrawings) { images, _ in
            let opacityValues = Array(stride(from: 1, to: SkinGenerator.maxOpacity, by: SkinGenerator.opacityStep))
            
            let drawables = zip(opacityValues, images)

            let size = CGSize(width: 512, height: 512)
            let format = UIGraphicsImageRendererFormat(for: traitCollection)

            let resultImage = UIGraphicsImageRenderer(size: size, format: format).image { context in
                if withBackground {
                    UIColor.canvasBackground.setFill()
                    context.cgContext.fill(CGRect(origin: .zero, size: size))
                }

                drawables.forEach { drawable in
                    let (opacity, image) = drawable
                    traitCollection.performAsCurrent {
                        image.draw(at: .zero, blendMode: .normal, alpha: opacity)
                    }
                }
            }
            completionHandler(resultImage)
        }
    }

    public var traitCollection: UITraitCollection

    // MARK: Boilerplate

    private static let skinPageCount = 4
    private static let maxOpacity = CGFloat(0.5)
    private static let opacityStep = CGFloat(-0.15)
}
