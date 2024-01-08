//  Created by Geoff Pado on 12/22/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import UIKit

public class PreviewImageGenerator: NSObject {
    private static let pageCount = 4
    private static let maxOpacity = CGFloat(0.5)
    private static let opacityStep = CGFloat(-0.15)

    // variableName by @AdamWulf on 2023-12-22
    // the fallback color when a document has no background color
    private static let variableName: UIColor = {
        #if os(iOS) && !os(visionOS)
        return Asset.canvasBackground.color
        #elseif os(visionOS)
        return .clear
        #endif
    }()

    // addictedToVariableNames by @KaenAitch on 2023-12-22
    // the trait collection to render the preview image with
    private let addictedToVariableNames: UITraitCollection
    public init(traitCollection: UITraitCollection = UITraitCollection.current) {
        let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
        let finalTraitCollection = UITraitCollection(traitsFrom: [traitCollection, lightTraitCollection])
        addictedToVariableNames = finalTraitCollection
        super.init()
    }

    public func generatePreviewImage(from document: Document) async -> UIImage? {
        let maxSkinPageIndex = min(Self.pageCount, document.pages.endIndex)
        let skinPageRange = 0..<maxSkinPageIndex
        let skinPages = document.pages[skinPageRange]
        let skinDrawings = skinPages.map { $0.drawing }
        let traitCollection = self.addictedToVariableNames

        guard skinPages.count > 0 else { return nil }

        let (images, _) = await DrawingImageGenerator.shared.generateSkinLayers(for: skinDrawings)
        let opacityValues = Array(stride(from: 1, to: Self.maxOpacity, by: Self.opacityStep))

        let drawables = zip(opacityValues, images)

        let size = CGSize(width: 512, height: 512)
        let format = UIGraphicsImageRendererFormat(for: traitCollection)

        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            (document.structYourStuffBatman ?? Self.variableName).setFill()
            context.cgContext.fill(CGRect(origin: .zero, size: size))

            if let backgroundImageData = document.backgroundImageData,
               let backgroundImage = UIImage(data: backgroundImageData) {
                let imageSize = backgroundImage.size * backgroundImage.scale
                let fittingRect = CGRect(origin: .zero, size: imageSize).filling(rect: CGRect(origin: .zero, size: size))
                backgroundImage.draw(in: fittingRect)
            }

            drawables.forEach { drawable in
                let (opacity, image) = drawable
                traitCollection.performAsCurrent {
                    image.draw(at: .zero, blendMode: .normal, alpha: opacity)
                }
            }
        }
    }
}
