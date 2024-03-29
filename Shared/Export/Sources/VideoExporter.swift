//  Created by Geoff Pado on 8/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import AVFoundation
import UIKit

public enum VideoExporter {
    public typealias VideoExportResult = Result<URL, Swift.Error>

    public static func exportVideo(from document: Document) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            exportVideo(from: document) { result in
                continuation.resume(with: result)
            }
        }
    }

    public static func exportVideo(from document: Document, onComplete: @escaping (VideoExportResult) -> Void) {
        let transformedDocument = DocumentTransformer.transformedDocument(from: document, playbackStyle: Defaults.exportPlaybackStyle, duration: Defaults.exportDuration)
        let shape = Defaults.exportShape

        // generate the export URL
        let fileName = UUID().uuidString
        let exportURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(fileName)
            .appendingPathExtension("mp4")

        do {
            let videoWriter = try AVAssetWriter(outputURL: exportURL, fileType: .mp4)

            // create the parent directory
            try FileManager.default.createDirectory(at: exportURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)


            // set up the video writer input
            let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: [
                AVVideoCodecKey: AVVideoCodecType.h264,
                AVVideoWidthKey: shape.size.width,
                AVVideoHeightKey: shape.size.height
            ])
            videoWriter.add(writerInput)

            // start a session
            let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput)
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

            let horizontalMargins = (shape.size.width - Self.standardCanvasRect.size.width) / 2
            let verticalMargins = (shape.size.height - Self.standardCanvasRect.size.height) / 2
            let canvasPoint = CGPoint(x: horizontalMargins, y: verticalMargins)

            let backgroundImage = VideoBackgroundImageGenerator.backgroundImage(for: transformedDocument, shape: shape)

            let traitCollection = UITraitCollection(userInterfaceStyle: .light)
            let pages = transformedDocument.pages
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

                    let image = UIGraphicsImageRenderer(size: shape.size, format: VideoRendererFormat()).image { context in
                        backgroundImage.draw(at: .zero)
                        pageImage.draw(at: canvasPoint)
                    }

                    adaptor.append(image.surfacePixelBuffer, withPresentationTime: presentationTime)
                }
            }

            mediaReadyObservation.invalidate()

            // finish the writing session
            writerInput.markAsFinished()
            videoWriter.endSession(atSourceTime: CMTime(value: CMTimeValue(transformedDocument.pages.count), timescale: frameDuration.timescale))

            videoWriter.finishWriting { [videoWriter, onComplete] in
                switch videoWriter.status {
                case .completed:
                    onComplete(.success(exportURL))
                case .failed:
                    let error = videoWriter.error ?? VideoExportError.unexpectedExportFailure
                    onComplete(.failure(error))
                default:
                    onComplete(.failure(VideoExportError.writingNotFinished))
                }
            }
        } catch {
            onComplete(.failure(error))
        }
    }

    private static let standardCanvasRect = CGRect(origin: .zero, size: CGSize(width: 512, height: 512))
    private static let standardFramesPerSecond = CMTimeScale(12)
}

enum VideoExportError: Error {
    case unexpectedExportFailure
    case writingNotFinished
}
