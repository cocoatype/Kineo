//  Created by Geoff Pado on 12/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import MobileCoreServices
import UIKit

class StickerGenerator: NSObject {
    static let standardStickerSize = CGSize(width: 408, height: 408)

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
        ]] as CFDictionary

        guard let destination = CGImageDestinationCreateWithURL(exportURL as CFURL, kUTTypePNG, document.pages.count, nil) else { throw Error.destinationCreationError }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)

        let backgroundImage = StickerBackgroundImageGenerator.backgroundImage(for: document)

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
