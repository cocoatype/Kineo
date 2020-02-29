//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit

class DrawingImageGenerator: NSObject {
    typealias Handler = (UIImage, PKDrawing) -> Void
    static let shared = DrawingImageGenerator()

    func generateThumbnail(for drawing: PKDrawing, completionHandler: @escaping Handler) {
        generateImage(for: drawing, size: Self.thumbnailSize, usesDisplayScale: true, completionHandler: completionHandler)
    }

    private func generateImage(for drawing: PKDrawing, size: CGSize, usesDisplayScale: Bool, completionHandler: @escaping Handler) {
        operationQueue.addOperation(DrawingImageGenerationOperation(drawing: drawing, size: size, usesDisplayScale: usesDisplayScale, completionHandler: completionHandler))
    }

    private static let thumbnailSize = CGSize(width: 36, height: 36)
    private let operationQueue = GeneratorQueue()
    private override init() {
        super.init()
    }

    private class GeneratorQueue: OperationQueue {
        override init() {
            super.init()
            maxConcurrentOperationCount = 1
            qualityOfService = .userInitiated
        }
    }
}

class DrawingImageGenerationOperation: Operation {
    init(drawing: PKDrawing, size: CGSize, usesDisplayScale: Bool, completionHandler: @escaping DrawingImageGenerator.Handler) {
        self.drawing = drawing
        self.size = size
        self.usesDisplayScale = usesDisplayScale
        self.completionHandler = completionHandler
    }

    override func main() {
        let traitCollection = UITraitCollection.current.withLightInterfaceStyle
        let renderScale = usesDisplayScale ? traitCollection.displayScale : 1

        traitCollection.performAsCurrent {
            let scale = size / Constants.canvasRect * renderScale
            let thumbnailImage = drawing.image(from: Constants.canvasRect, scale: scale)
            completionHandler(thumbnailImage, drawing)
        }
    }

    private let drawing: PKDrawing
    private let size: CGSize
    private let usesDisplayScale: Bool
    private let completionHandler: DrawingImageGenerator.Handler
}
