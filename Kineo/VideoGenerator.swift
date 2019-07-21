//  Created by Geoff Pado on 7/20/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import AVFoundation
import UIKit

class VideoGenerator: NSObject {
    func generateVideo(from document: Document, completionHandler: @escaping ((VideoGenerationResult) -> Void)) {
        do {
            guard exportSession == nil else { throw Error.videoGeneratorAlreadyExporting }

            // generate images from all of the document's pages
            let images = document.pages.lazy.map { $0.drawing }.map { $0.image(from: VideoGenerator.standardCanvasRect, scale: 1.0) }

            // save images to temporary URLs
            let temporaryDirectoryURL = FileManager.default.temporaryDirectory

            let imageURLs = try images.map { image throws -> URL in
                guard let data = image.pngData() else { throw Error.noImageData }
                let imageName = UUID().uuidString
                let imageURL = temporaryDirectoryURL.appendingPathComponent(imageName).appendingPathExtension("png")
                try data.write(to: imageURL)
                return imageURL
            }

            // create a composition
            let composition = AVMutableComposition()
            let frameDuration = CMTime(value: 1, timescale: VideoGenerator.standardFramesPerSecond)

            // create a track to display the images in
            let compositionTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)

            // for each image
            let indexes = 0..<imageURLs.count
            try zip(indexes, imageURLs).forEach { imageWithIndex in
                let (index, imageURL) = imageWithIndex

                // create an AVURLAsset
                let imageAsset = AVURLAsset(url: imageURL, options: [AVURLAssetPreferPreciseDurationAndTimingKey: true])
                guard let assetTrack = imageAsset.tracks(withMediaType: .video).first else { throw Error.noAssetTrack }

                // insert a time range
                let startTime = CMTime(value: CMTimeValue(index), timescale: frameDuration.timescale)
                let timeRange = CMTimeRange(start: .zero, duration: frameDuration)
                try compositionTrack?.insertTimeRange(timeRange, of: assetTrack, at: startTime)
            }

            // create a video composition
            let videoCompositionInstruction = AVMutableVideoCompositionInstruction()
            videoCompositionInstruction.backgroundColor = UIColor.white.cgColor
            videoCompositionInstruction.timeRange = CMTimeRange(start: .zero, duration: CMTime(value: CMTimeValue(imageURLs.count), timescale: frameDuration.timescale))

            let videoComposition = AVMutableVideoComposition()
            videoComposition.instructions = [videoCompositionInstruction]
            videoComposition.frameDuration = frameDuration
            videoComposition.renderSize = VideoGenerator.standardCanvasSize

            // create an asset export session
            let exportURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")

            guard let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPreset1280x720) else { throw Error.creatingExportSessionFailed }
            exportSession.outputFileType = .mp4
            exportSession.outputURL = exportURL
            exportSession.shouldOptimizeForNetworkUse = true
            exportSession.videoComposition = videoComposition

            // export
            exportSession.exportAsynchronously { [weak self] in
                guard let status = self?.exportSession?.status else {
                    let error = self?.exportSession?.error ?? Error.unexpectedExportFailure
                    completionHandler(.failure(error))
                    return
                }

                switch status {
                case .completed:
                    completionHandler(.success(exportURL))
                case .failed:
                    let error = self?.exportSession?.error ?? Error.unexpectedExportFailure
                    completionHandler(.failure(error))
                default: return
                }
            }

            self.exportSession = exportSession
        } catch {
            completionHandler(.failure(error))
        }
    }

    // MARK: Errors

    private enum Error: Swift.Error {
        case creatingExportSessionFailed
        case noImageData
        case noAssetTrack
        case unexpectedExportFailure
        case videoGeneratorAlreadyExporting
    }

    // MARK: Boilerplate

    private var exportSession: AVAssetExportSession?

    private static let standardCanvasRect = CGRect(origin: .zero, size: standardCanvasSize)
    private static let standardCanvasSize = CGSize(width: 512, height: 512)
    private static let standardFramesPerSecond = CMTimeScale(12)

    typealias VideoGenerationResult = Result<URL, Swift.Error>
}

class VideoGeneratingOperation: Operation {}
