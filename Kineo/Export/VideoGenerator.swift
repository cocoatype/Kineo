//  Created by Geoff Pado on 7/20/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import AVFoundation
import CoreServices
import Data
import LinkPresentation
import UIKit

class VideoProvider: UIActivityItemProvider {
    init(document: Document) throws {
        self.document = DocumentTransformer.transformedDocument(from: document, using: Defaults.exportSettings)

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
            AVVideoWidthKey: Self.standardCanvasSize.width,
            AVVideoHeightKey: Self.standardCanvasSize.height
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
                let image = page.drawing.image(from: Self.standardCanvasRect, scale: 1)

                mediaReadyCondition.lock()
                while writerInput.isReadyForMoreMediaData == false {
                    mediaReadyCondition.wait()
                }
                mediaReadyCondition.unlock()

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
    private let videoWriter: AVAssetWriter

    private static let standardCanvasRect = CGRect(origin: .zero, size: standardCanvasSize)
    private static let standardCanvasSize = CGSize(width: 512, height: 512)
    private static let standardFramesPerSecond = CMTimeScale(12)
    private static let metadataTitle = NSLocalizedString("VideoProvider.metadataTitle", comment: "Title to display when sharing a video")

    typealias VideoGenerationResult = Result<URL, Swift.Error>
}
