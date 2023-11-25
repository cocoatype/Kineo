//  Created by Geoff Pado on 8/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import AVFoundation
import UIKit
import VideoToolbox

@available(visionOS 1.0, iOS 17.0, *)
public enum VideoExporter3D {
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
            // = AVOutputSettingsAssistant(preset: .mvhevc1440x1440)!.videoSettings
            let assistantSettings: [String: Any] = [
                AVVideoWidthKey: 720,
                AVVideoHeightKey: 720,
                AVVideoScalingModeKey: AVVideoScalingModeResizeAspectFill,
                AVVideoCompressionPropertiesKey: [
                    kVTCompressionPropertyKey_MVHEVCLeftAndRightViewIDs: [0, 1],
                    kVTCompressionPropertyKey_MVHEVCVideoLayerIDs: [0, 1],
                    kVTCompressionPropertyKey_MVHEVCViewIDs: [0, 1]
                ],
                AVVideoCodecKey: AVVideoCodecType.hevc,
            ]
            let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: assistantSettings)
            videoWriter.add(writerInput)

            // start a session
            let adaptor = AVAssetWriterInputTaggedPixelBufferGroupAdaptor(assetWriterInput: writerInput)
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
            let pages = transformedDocument.pages
            pages.enumerated().forEach { pageWithIndex in
                let (index, page) = pageWithIndex
                let presentationTime = CMTime(value: CMTimeValue(index), timescale: frameDuration.timescale)
                traitCollection.performAsCurrent {
                    let pageImageLeft = PageImageRenderer.image(for: page, eye: .left)
                    let pageImageRight = PageImageRenderer.image(for: page, eye: .right)

                    mediaReadyCondition.lock()
                    while writerInput.isReadyForMoreMediaData == false {
                        mediaReadyCondition.wait()
                    }
                    mediaReadyCondition.unlock()

                    let leftTaggedBuffer = CMTaggedBuffer(
                        tags: [
                            .stereoView(.leftEye),
                            .videoLayerID(0)
                        ],
                        pixelBuffer: pageImageLeft.surfacePixelBuffer
                    )
                    let rightTaggedBuffer = CMTaggedBuffer(
                        tags: [
                            .stereoView(.rightEye),
                            .videoLayerID(1)
                        ],
                        pixelBuffer: pageImageRight.surfacePixelBuffer
                    )
                    if adaptor.appendTaggedBuffers([leftTaggedBuffer, rightTaggedBuffer], withPresentationTime: presentationTime) == false {
                        print("uh oh!")
                    }
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

    static let standardCanvasRect = CGRect(origin: .zero, size: CGSize(width: 512, height: 512))
    private static let standardFramesPerSecond = CMTimeScale(12)
}
