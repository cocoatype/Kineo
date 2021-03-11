//  Created by Geoff Pado on 7/20/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import AVFoundation
import CoreServices
import Data
import LinkPresentation
import UIKit

enum VideoShape {
    case square, squarePlain, portrait, landscape

    var size: CGSize {
        switch self {
        case .square, .squarePlain: return Self.standardCanvasSize
        case .portrait: return CGSize(width: 720, height: 1280)
        case .landscape: return CGSize(width: 1280, height: 720)
        }
    }

    private static let standardCanvasSize = CGSize(width: 512, height: 512)
}

class VideoProvider: UIActivityItemProvider {
    init(document: Document, shape: VideoShape = .portrait) throws {
        self.document = DocumentTransformer.transformedDocument(from: document, using: Defaults.exportSettings)
        self.shape = shape

        // generate the export URL
        let fileName = UUID().uuidString
        exportURL = FileManager.default.temporaryDirectory
          .appendingPathComponent(fileName)
          .appendingPathExtension("mp4")

        videoWriter = try AVAssetWriter(outputURL: exportURL, fileType: .mp4)

        super.init(placeholderItem: exportURL)

        // create the parent directory
        try FileManager.default.createDirectory(at: exportURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
    }

    override var item: Any {
        let videoGeneratedCondition = NSCondition()
        var isFinishedWriting = false
        generateVideo(from: document, completionHandler: { [weak videoGeneratedCondition] _ in
            // TODO (#34): Handle failure case?
            isFinishedWriting = true
            videoGeneratedCondition?.lock()
            videoGeneratedCondition?.signal()
            videoGeneratedCondition?.unlock()
        })

        videoGeneratedCondition.lock()
        while isFinishedWriting == false {
            videoGeneratedCondition.wait()
        }
        videoGeneratedCondition.unlock()

        return exportURL
    }

    private func generateVideo(from document: Document, completionHandler: @escaping ((VideoGenerationResult) -> Void)) {
        // set up the video writer input
        let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: shape.size.width,
            AVVideoHeightKey: shape.size.height
        ])
        videoWriter.add(writerInput)

        // start a session
        let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput, sourcePixelBufferAttributes: nil)
        videoWriter.startWriting()
        videoWriter.startSession(atSourceTime: .zero)

        // write images as samples
        let frameDuration = CMTime(value: 1, timescale: Self.standardFramesPerSecond)

        let mediaReadyCondition = NSCondition()
        let mediaReadyObservation = writerInput.observe(\.isReadyForMoreMediaData) { [weak mediaReadyCondition] input, _ in
            if input.isReadyForMoreMediaData {
                mediaReadyCondition?.lock()
                mediaReadyCondition?.signal()
                mediaReadyCondition?.unlock()
            }
        }

        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        let pages = document.pages
        pages.enumerated().forEach { pageWithIndex in
            let (index, page) = pageWithIndex
            let presentationTime = CMTime(value: CMTimeValue(index), timescale: frameDuration.timescale)
            traitCollection.performAsCurrent {
                let pageImage = page.drawing.image(from: Self.standardCanvasRect, scale: 1)

                mediaReadyCondition.lock()
                while writerInput.isReadyForMoreMediaData == false {
                    mediaReadyCondition.wait()
                }
                mediaReadyCondition.unlock()

                let format = UIGraphicsImageRendererFormat()
                format.opaque = true
                format.scale = 1

                let image = UIGraphicsImageRenderer(size: shape.size, format: format).image { context in
                    // draw a background
                    UIColor.appBackground.setFill()
                    context.fill(CGRect(origin: .zero, size: shape.size))

                    let horizontalMargins = (shape.size.width - pageImage.size.width) / 2
                    let verticalMargins = (shape.size.height - pageImage.size.height) / 2
                    let canvasPoint = CGPoint(x: horizontalMargins, y: verticalMargins)

                    // draw a canvas
                    let cgContext = context.cgContext

                    let canvasRect = CGRect(origin: canvasPoint, size: pageImage.size)
                    let canvasPath = UIBezierPath(roundedRect: canvasRect, cornerRadius: 8).cgPath

                    cgContext.setFillColor(UIColor.canvasBackground.cgColor)
                    cgContext.addPath(canvasPath)

                    // draw the lower shadow
                    cgContext.saveGState()
                    cgContext.setShadow(offset: CGSize(width: 0, height: 12), blur: 32, color: UIColor.canvasShadowDark.cgColor)
                    cgContext.fillPath()
                    cgContext.restoreGState()

                    // draw the upper shadow
                    cgContext.saveGState()
                    cgContext.setShadow(offset: CGSize(width: 0, height: -12), blur: 32, color: UIColor.canvasShadowLight.cgColor)
                    cgContext.fillPath()
                    cgContext.restoreGState()

                    // drawn an animation frame
                    pageImage.draw(at: CGPoint(x: horizontalMargins, y: verticalMargins))
                }

                adaptor.append(image.pixelBuffer, withPresentationTime: presentationTime)
            }
        }

        mediaReadyObservation.invalidate()

        // finish the writing session
        writerInput.markAsFinished()
        videoWriter.endSession(atSourceTime: CMTime(value: CMTimeValue(document.pages.count), timescale: frameDuration.timescale))
        videoWriter.finishWriting { [weak self, videoWriter] in
            switch videoWriter.status {
            case .completed:
                guard let exportURL = self?.exportURL else { completionHandler(.failure(Error.unexpectedExportFailure)); break }
                completionHandler(.success(exportURL))
            case .failed: completionHandler(.failure(videoWriter.error ?? Error.unexpectedExportFailure))
            default: break
            }
        }
    }

    // MARK: Errors

    private enum Error: Swift.Error {
        case unexpectedExportFailure
    }

    // MARK: Metadata

    override func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.originalURL = WebViewController.websiteURL(withPath: "")
        metadata.imageProvider = DocumentThumbnailProvider(document: document)
        metadata.iconProvider = DocumentThumbnailProvider(document: document)
        metadata.title = Self.metadataTitle
        return metadata
    }

    // MARK: Boilerplate

    private let document: Document
    private let exportURL: URL
    private let shape: VideoShape
    private let videoWriter: AVAssetWriter

    private static let standardCanvasRect = CGRect(origin: .zero, size: CGSize(width: 512, height: 512))
    private static let standardFramesPerSecond = CMTimeScale(12)
    private static let metadataTitle = NSLocalizedString("VideoProvider.metadataTitle", comment: "Title to display when sharing a video")

    typealias VideoGenerationResult = Result<URL, Swift.Error>
}
