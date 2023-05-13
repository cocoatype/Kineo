//  Created by Geoff Pado on 5/12/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Data
import MobileCoreServices
import UIKit

class GIFProvider: UIActivityItemProvider {
    static let standardStickerSize = CGSize(width: 512, height: 512)

    static func exportedURL(from document: Document) throws -> URL {
        // generate the export URL
        let fileName = "Animation"
        let exportURL = FileManager.default.temporaryDirectory
          .appendingPathComponent(fileName)
          .appendingPathExtension("gif")

        // create the parent directory
        try FileManager.default.createDirectory(at: exportURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)

        // magic happens here
        let fileProperties = [kCGImagePropertyGIFDictionary: [
            kCGImagePropertyGIFLoopCount: 0
        ]]
        let frameProperties = [kCGImagePropertyGIFDictionary: [
            kCGImagePropertyGIFDelayTime: 1 / Constants.framesPerSecond
        ]] as CFDictionary

        guard let destination = CGImageDestinationCreateWithURL(exportURL as CFURL, kUTTypeGIF, document.pages.count, nil) else { throw Error.destinationCreationError }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)

        let backgroundImage = GIFBackgroundImageGenerator.backgroundImage(for: document)

        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        traitCollection.performAsCurrent {
            let stickerScale = Self.standardStickerSize / Constants.canvasRect
            document.pages.forEach { page in
                let image = UIGraphicsImageRenderer(size: Self.standardStickerSize).image { context in

                    backgroundImage.draw(at: .zero)

                    let pageImage = page.drawing.image(from: Constants.canvasRect, scale: stickerScale)
                    pageImage.draw(at: .zero)
                }
                guard let cgImage = image.cgImage else { return }
                CGImageDestinationAddImage(destination, cgImage, frameProperties as CFDictionary)
            }
        }

        guard CGImageDestinationFinalize(destination) else { throw Error.finalizeError }

        return exportURL
    }

    private enum Error: Swift.Error {
        case destinationCreationError
        case imageCreationError
        case finalizeError
    }
}

class GIFBackgroundImageGenerator: NSObject {
    static func backgroundImage(for document: Document) -> UIImage {
        let stickerSize = GIFProvider.standardStickerSize
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
