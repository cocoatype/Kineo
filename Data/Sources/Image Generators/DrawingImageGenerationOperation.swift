//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import SharedPhone
#elseif os(visionOS)
import SharedVision
#endif

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
            let drawingImage = drawing.image(from: Constants.canvasRect, scale: max(1, scale))
            let renderer = UIGraphicsImageRenderer(size: size)
            let thumbnailImage = renderer.image { _ in
                drawingImage.draw(in: CGRect(origin: .zero, size: size))
            }
            resultImage = thumbnailImage
            completionHandler?(thumbnailImage, drawing)
        }
    }

    private let drawing: PKDrawing
    private let size: CGSize
    private let usesDisplayScale: Bool
    private let completionHandler: DrawingImageGenerator.Handler?
}
