//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import PencilKit

class DrawingImageGenerationOperation: Operation {
    init(drawing: PKDrawing, size: CGSize, usesDisplayScale: Bool, completionHandler: DrawingImageGenerator.Handler?) {
        self.drawing = drawing
        self.size = size
        self.usesDisplayScale = usesDisplayScale
        self.completionHandler = completionHandler
    }

    var resultImage: UIImage?

    override func main() {
        let traitCollection = UITraitCollection.current.withLightInterfaceStyle
        let renderScale = usesDisplayScale ? traitCollection.displayScale : 1

        traitCollection.performAsCurrent {
            let scale = size / Constants.canvasRect * renderScale
            let thumbnailImage = drawing.image(from: Constants.canvasRect, scale: scale)
            resultImage = thumbnailImage
            completionHandler?(thumbnailImage, drawing)
        }
    }

    private let drawing: PKDrawing
    private let size: CGSize
    private let usesDisplayScale: Bool
    private let completionHandler: DrawingImageGenerator.Handler?
}
