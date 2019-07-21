//  Created by Geoff Pado on 7/20/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import AVFoundation
import UIKit

class VideoGenerator: NSObject {
    func generateVideo(from document: Document, completionHandler: @escaping ((VideoGenerationResult) -> Void)) {
        do {
            // generate the export URL
            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
            let fileName = UUID().uuidString
            let exportURL = temporaryDirectoryURL
              .appendingPathComponent(fileName)
              .appendingPathExtension("mp4")

            // set up the video writer
            let videoWriter = try AVAssetWriter(outputURL: exportURL, fileType: .mp4)
            let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: [
                AVVideoCodecKey: AVVideoCodecType.h264,
                AVVideoWidthKey: VideoGenerator.standardCanvasSize.width,
                AVVideoHeightKey: VideoGenerator.standardCanvasSize.height
            ])
            videoWriter.add(writerInput)

            // start a session
            let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput, sourcePixelBufferAttributes: nil)
            videoWriter.startWriting()
            videoWriter.startSession(atSourceTime: .zero)

            // write images as samples
            let frameDuration = CMTime(value: 1, timescale: VideoGenerator.standardFramesPerSecond)

            let mediaReadyCondition = NSCondition()
            let mediaReadyObservation = writerInput.observe(\.isReadyForMoreMediaData) { [weak mediaReadyCondition] _, change in
                guard let isReady = change.newValue else { return }

                if isReady {
                    mediaReadyCondition?.lock()
                    mediaReadyCondition?.signal()
                    mediaReadyCondition?.unlock()
                }
            }

            let pages = document.pages
            pages.enumerated().forEach { pageWithIndex in
                let (index, page) = pageWithIndex
                let presentationTime = CMTime(value: CMTimeValue(index), timescale: frameDuration.timescale)
                let image = page.drawing.image(from: VideoGenerator.standardCanvasRect, scale: 1)

                mediaReadyCondition.lock()
                while writerInput.isReadyForMoreMediaData == false {
                    mediaReadyCondition.wait()
                }
                mediaReadyCondition.unlock()

                adaptor.append(image.pixelBuffer, withPresentationTime: presentationTime)
            }

            mediaReadyObservation.invalidate()

            // finish the writing session
            writerInput.markAsFinished()
            videoWriter.endSession(atSourceTime: CMTime(value: CMTimeValue(document.pages.count), timescale: frameDuration.timescale))
            videoWriter.finishWriting { [weak videoWriter] in
                guard let videoWriter = videoWriter else {
                    completionHandler(.failure(Error.unexpectedExportFailure))
                    return
                }

                switch videoWriter.status {
                case .completed: completionHandler(.success(exportURL))
                case .failed: completionHandler(.failure(videoWriter.error ?? Error.unexpectedExportFailure))
                default: break
                }
            }
        } catch {
            completionHandler(.failure(error))
        }
    }

    // MARK: Errors

    private enum Error: Swift.Error {
        case unexpectedExportFailure
    }

    // MARK: Boilerplate

    private static let standardCanvasRect = CGRect(origin: .zero, size: standardCanvasSize)
    private static let standardCanvasSize = CGSize(width: 512, height: 512)
    private static let standardFramesPerSecond = CMTimeScale(12)

    typealias VideoGenerationResult = Result<URL, Swift.Error>
}
