//  Created by Geoff Pado on 12/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import MobileCoreServices
import UIKit

class StickerGenerator: NSObject {
    static func sticker(from document: Document) throws -> URL {
        // generate the export URL
        let fileName = document.uuid.uuidString
        let exportURL = FileManager.default.temporaryDirectory
          .appendingPathComponent(fileName)
          .appendingPathExtension("png")

        // create the parent directory
        try FileManager.default.createDirectory(at: exportURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)

        // magic happens here
        let fileProperties = [kCGImagePropertyPNGDictionary: [
            kCGImagePropertyAPNGLoopCount: 0
        ]]
        let frameProperties = [kCGImagePropertyPNGDictionary: [
            kCGImagePropertyAPNGDelayTime: 1 / Constants.framesPerSecond
        ]]

        guard let destination = CGImageDestinationCreateWithURL(exportURL as CFURL, kUTTypePNG, document.pages.count, nil) else { throw Error.destinationCreationError }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)

        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        traitCollection.performAsCurrent {
            let stickerScale = Self.standardStickerSize / Constants.canvasRect
            document.pages.forEach { page in
                let image = UIGraphicsImageRenderer(size: Self.standardStickerSize).image { context in
                    document.canvasBackgroundColor.setFill()
                    context.cgContext.fill(CGRect(origin: .zero, size: Self.standardStickerSize))
                    guard let image = page.drawing.image(from: Constants.canvasRect, scale: stickerScale).cgImage else { return }
                    context.cgContext.draw(image, in: CGRect(origin: .zero, size: Self.standardStickerSize))
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

    // MARK: Boilerplate

    private static let standardStickerSize = CGSize(width: 408, height: 408)
}
