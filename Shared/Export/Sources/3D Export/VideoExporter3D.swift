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
            let mediaReadyCondition = NSCondition()
            let mediaReadyObservation = writerInput.observe(\.isReadyForMoreMediaData) { [weak mediaReadyCondition] input, _ in
                if input.isReadyForMoreMediaData {
                    mediaReadyCondition?.lock()
                    mediaReadyCondition?.signal()
                    mediaReadyCondition?.unlock()
                }
            }

            let duration = VideoBufferGenerator3D.exportVideo(from: document) { taggedBuffers, presentationTime in
                mediaReadyCondition.lock()
                while writerInput.isReadyForMoreMediaData == false {
                    mediaReadyCondition.wait()
                }
                mediaReadyCondition.unlock()

                if adaptor.appendTaggedBuffers(taggedBuffers, withPresentationTime: presentationTime) == false {
                    print("uh oh!")
                }
            }

            mediaReadyObservation.invalidate()

            // finish the writing session
            writerInput.markAsFinished()
            videoWriter.endSession(atSourceTime: duration)

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
}
