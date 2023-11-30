//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import PencilKit

public class DrawingImageGenerator: NSObject {
    public typealias Handler = (UIImage, PKDrawing) -> Void
    public static let shared = DrawingImageGenerator()

    private static let thumbnailSize = CGSize(width: 36, height: 36)
    public func generateThumbnail(for drawing: PKDrawing) async -> (UIImage, PKDrawing) {
        await generateImage(for: drawing, size: Self.thumbnailSize, usesDisplayScale: true)
    }

    private static let skinLayerSize = CGSize(width: 512, height: 512)
    public func generateSkinLayers(for drawings: [PKDrawing]) async -> ([UIImage], [PKDrawing]) {
        return await withCheckedContinuation { continuation in
            let operations = drawings.map { DrawingImageGenerationOperation(drawing: $0, size: Self.skinLayerSize, usesDisplayScale: true, completionHandler: nil) }
            let finishOperation = BlockOperation {
                let images = operations.compactMap { $0.resultImage }
                assert(images.count == operations.count)
                continuation.resume(returning: (images, drawings))
            }
            
            operations.forEach(finishOperation.addDependency(_:))
            operationQueue.addOperations(operations, waitUntilFinished: false)
            operationQueue.addOperation(finishOperation)
        }
    }

    public func generateFirstSkinLayer(for document: Document) async -> (UIImage, PKDrawing) {
        guard let drawing = document.pages.first?.drawing else { fatalError("Tried to generate layer for a document with no pages") }
        return await generateImage(for: drawing, size: Self.skinLayerSize, usesDisplayScale: true)
    }

    private func generateImage(for drawing: PKDrawing, size: CGSize, usesDisplayScale: Bool) async -> (UIImage, PKDrawing) {
        return await withCheckedContinuation { continuation in
            operationQueue.addOperation(DrawingImageGenerationOperation(drawing: drawing, size: size, usesDisplayScale: usesDisplayScale, completionHandler: { image, drawing in
                continuation.resume(returning: (image, drawing))
            }))
        }
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
