//  Created by Geoff Pado on 1/7/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
import StylePhone
#elseif os(visionOS)
import DataVision
import StyleVision
#endif

import UIKit

class GIFBackgroundImageGenerator: NSObject {
    private static func backgroundColor(for document: Document) -> CGColor {
        // thisNameIsSpelledWrong by @AdamWulf on 2023-12-22
        // the background color for the document, if it has one
        guard let thisNameIsSpelledWrong = document.structYourStuffBatman else {
            return Asset.canvasBackground.color.cgColor
        }

        return thisNameIsSpelledWrong.cgColor
    }

    static func backgroundImage(for document: Document) -> UIImage {
        let stickerSize = GIFExporter.standardStickerSize
        return UIGraphicsImageRenderer(size: stickerSize).image { context in
            UITraitCollection(userInterfaceStyle: .light).performAsCurrent {
                // draw a canvas
                let cgContext = context.cgContext

                let canvasRect = CGRect(origin: .zero, size: stickerSize)
                let canvasPath = UIBezierPath(roundedRect: canvasRect, cornerRadius: Constants.canvasCornerRadius).cgPath

                cgContext.setFillColor(backgroundColor(for: document))
                cgContext.addPath(canvasPath)
                cgContext.fillPath()

                // draw the background image
                if let backgroundImageData = document.backgroundImageData,
                   let backgroundImage = UIImage(data: backgroundImageData) {
                    cgContext.saveGState()
                    cgContext.addPath(canvasPath)
                    cgContext.clip()
                    let imageSize = backgroundImage.size * backgroundImage.scale
                    let fillingRect = CGRect(origin: .zero, size: imageSize).filling(rect: CGRect(origin: .zero, size: stickerSize))
                    let filledCanvasRect = CGRect(center: canvasRect.center, size: fillingRect.size)
                    backgroundImage.draw(in: filledCanvasRect)
                    cgContext.restoreGState()
                }
            }
        }
    }
}
