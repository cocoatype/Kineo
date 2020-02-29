//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit

class FilmStripThumbnailGenerator: NSObject {
    func generateThumbnail(for drawing: PKDrawing, completionHandler: @escaping ((UIImage, PKDrawing) -> Void)) {
        let traitCollection = UITraitCollection.current.withLightInterfaceStyle
        operationQueue.addOperation {
            traitCollection.performAsCurrent {
                let scale = Self.thumbnailSize / Constants.canvasRect * traitCollection.displayScale
                let thumbnailImage = drawing.image(from: Constants.canvasRect, scale: scale)
                completionHandler(thumbnailImage, drawing)
            }
        }
    }

    private static let thumbnailSize = CGSize(width: 36, height: 36)
    private let operationQueue = GeneratorQueue()

    private class GeneratorQueue: OperationQueue {
        override init() {
            super.init()
            maxConcurrentOperationCount = 1
            qualityOfService = .userInitiated
        }
    }
}
