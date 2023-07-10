//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import PencilKit

public class DrawingImageGenerator: NSObject {
    public typealias Handler = (UIImage, PKDrawing) -> Void
    public static let shared = DrawingImageGenerator()

    private static let thumbnailSize = CGSize(width: 36, height: 36)
    public func generateThumbnail(for drawing: PKDrawing, completionHandler: @escaping Handler) {
        generateImage(for: drawing, size: Self.thumbnailSize, usesDisplayScale: true, completionHandler: completionHandler)
    }

    private static let skinLayerSize = CGSize(width: 512, height: 512)
    public func generateSkinLayers(for drawings: [PKDrawing], completionHandler: @escaping (([UIImage], [PKDrawing]) -> Void)) {
        let operations = drawings.map { DrawingImageGenerationOperation(drawing: $0, size: Self.skinLayerSize, usesDisplayScale: true, completionHandler: nil) }
        let finishOperation = BlockOperation {
            let images = operations.compactMap { $0.resultImage }
            assert(images.count == operations.count)
            completionHandler(images, drawings)
        }

        operations.forEach(finishOperation.addDependency(_:))
        operationQueue.addOperations(operations, waitUntilFinished: false)
        operationQueue.addOperation(finishOperation)
    }

    public func generateSkinLayers(for drawings: [PKDrawing]) async -> [UIImage] {
        return await withCheckedContinuation { continuation in
            generateSkinLayers(for: drawings) { images, _ in
                continuation.resume(returning: images)
            }
        }
    }

    public func generateFirstSkinLayer(for document: Document, completionHandler: @escaping Handler) {
        guard let drawing = document.pages.first?.drawing else { fatalError("Tried to generate layer for a document with no pages") }
        generateImage(for: drawing, size: Self.skinLayerSize, usesDisplayScale: true, completionHandler: completionHandler)
    }

    private func generateImage(for drawing: PKDrawing, size: CGSize, usesDisplayScale: Bool, completionHandler: @escaping Handler) {
        operationQueue.addOperation(DrawingImageGenerationOperation(drawing: drawing, size: size, usesDisplayScale: usesDisplayScale, completionHandler: completionHandler))
    }

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
