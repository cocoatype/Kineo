//  Created by Geoff Pado on 6/27/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

class StickerBackgroundImageGenerator: NSObject {
    static func backgroundImage(for document: Document) -> UIImage {
        let stickerSize = StickerGenerator.standardStickerSize
        return UIGraphicsImageRenderer(size: stickerSize).image { context in
            UITraitCollection(userInterfaceStyle: .light).performAsCurrent {
                // draw a canvas
                let cgContext = context.cgContext

                let canvasRect = CGRect(origin: .zero, size: stickerSize)
                let canvasPath = UIBezierPath(roundedRect: canvasRect, cornerRadius: Constants.canvasCornerRadius).cgPath

                cgContext.setFillColor(document.canvasBackgroundColor.cgColor)
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
