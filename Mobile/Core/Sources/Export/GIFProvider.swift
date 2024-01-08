//  Created by Geoff Pado on 5/12/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataPhone
import MobileCoreServices
import UIKit

class GIFProvider: UIActivityItemProvider {
    static let standardStickerSize = CGSize(width: 512, height: 512)

    static func exportedURL(from document: Document) throws -> URL {
        // generate the export URL
        let fileName = NSLocalizedString("GIFProvider.fileName", comment: "File name for an exported animated GIF")
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
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        traitCollection.performAsCurrent {
            let stickerScale = Self.standardStickerSize / Constants.canvasRect
            document.pages.forEach { page in
                let image = UIGraphicsImageRenderer(size: Self.standardStickerSize, format: format).image { context in
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
