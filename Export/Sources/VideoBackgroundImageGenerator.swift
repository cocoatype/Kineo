//  Created by Geoff Pado on 5/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import UIKit

class VideoBackgroundImageGenerator: NSObject {
    static func backgroundImage(for document: Document, shape: ExportShape) -> UIImage {
        let horizontalMargins = (shape.size.width - Constants.canvasSize.width) / 2
        let verticalMargins = (shape.size.height - Constants.canvasSize.height) / 2
        let canvasPoint = CGPoint(x: horizontalMargins, y: verticalMargins)

        let backgroundTraitCollection = UITraitCollection(userInterfaceStyle: Defaults.exportBackgroundStyle)
        return UIGraphicsImageRenderer(size: shape.size, format: VideoRendererFormat()).image { context in
            backgroundTraitCollection.performAsCurrent {
                // draw a background
                UIColor.appBackground.setFill()
                context.fill(CGRect(origin: .zero, size: shape.size))

                // draw a canvas
                let cgContext = context.cgContext

                let canvasRect = CGRect(origin: canvasPoint, size: Constants.canvasSize)
                let canvasPath = UIBezierPath(roundedRect: canvasRect, cornerRadius: Constants.canvasCornerRadius).cgPath

                cgContext.setFillColor(document.canvasBackgroundColor.cgColor)
                cgContext.addPath(canvasPath)

                // draw the lower shadow
                cgContext.saveGState()
                cgContext.setShadow(offset: CGSize(width: 0, height: 12), blur: 32, color: UIColor.canvasShadowDark.cgColor)
                cgContext.fillPath()
                cgContext.restoreGState()

                // draw the upper shadow
                cgContext.saveGState()
                cgContext.setShadow(offset: CGSize(width: 0, height: -12), blur: 32, color: UIColor.canvasShadowLight.cgColor)
                cgContext.fillPath()
                cgContext.restoreGState()

                // draw the background image
                if let backgroundImageData = document.backgroundImageData,
                   let backgroundImage = UIImage(data: backgroundImageData) {
                    cgContext.saveGState()
                    cgContext.addPath(canvasPath)
                    cgContext.clip()
                    let imageSize = backgroundImage.size * backgroundImage.scale
                    let fillingRect = CGRect(origin: .zero, size: imageSize).filling(rect: CGRect(origin: .zero, size: Constants.canvasSize))
                    let filledCanvasRect = CGRect(center: canvasRect.center, size: fillingRect.size)
                    backgroundImage.draw(in: filledCanvasRect)
                    cgContext.restoreGState()
                }

                // draw the watermark, if needed
                if let watermark = UIImage(named: "Watermark"),
                   Defaults.exportHideWatermark == false {
                    let point = CGPoint(x: canvasRect.midX, y: canvasRect.maxY + 16 + (watermark.size.height / 2))
                    let rect = CGRect(center: point, size: watermark.size)
                    watermark.draw(in: rect)
                }
            }
        }
    }
}
