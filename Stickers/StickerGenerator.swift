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
            kCGImagePropertyAPNGDelayTime: 1 / Self.standardFramesPerSecond
        ]]

        guard let destination = CGImageDestinationCreateWithURL(exportURL as CFURL, kUTTypePNG, document.pages.count, nil) else { throw Error.destinationCreationError }
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)

        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        traitCollection.performAsCurrent {
            let stickerScale = Self.standardStickerSize.width / Self.standardCanvasSize.width
            document.pages.forEach { page in
                guard let image = page.drawing.image(from: Self.standardCanvasRect, scale: stickerScale).cgImage else { return }
                CGImageDestinationAddImage(destination, image, frameProperties as CFDictionary)
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

    private static let standardCanvasRect = CGRect(origin: .zero, size: standardCanvasSize)
    private static let standardCanvasSize = CGSize(width: 512, height: 512)
    private static let standardStickerSize = CGSize(width: 408, height: 408)
    private static let standardFramesPerSecond = CGFloat(12)
}
