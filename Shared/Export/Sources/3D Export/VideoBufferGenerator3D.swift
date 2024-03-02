//  Created by Geoff Pado on 2/19/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import AVFoundation
import UIKit
import VideoToolbox

@available(visionOS 1.0, iOS 17.0, *)
public enum VideoBufferGenerator3D {
    public static func exportVideo(from document: Document, actions: @escaping ([CMTaggedBuffer], CMTime) -> Void) -> CMTime {
        let transformedDocument = DocumentTransformer.transformedDocument(from: document, playbackStyle: Defaults.exportPlaybackStyle, duration: Defaults.exportDuration)

        let frameDuration = CMTime(value: 1, timescale: VideoGenerationConstants.standardFramesPerSecond)

        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        let pages = transformedDocument.pages
        pages.enumerated().forEach { pageWithIndex in
            let (index, page) = pageWithIndex
            let presentationTime = CMTime(value: CMTimeValue(index), timescale: frameDuration.timescale)
            traitCollection.performAsCurrent {
                let pageImageLeft = PageImageRenderer.image(for: page, eye: .left)
                let pageImageRight = PageImageRenderer.image(for: page, eye: .right)

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

                actions([leftTaggedBuffer, rightTaggedBuffer], presentationTime)
            }
        }

        return CMTime(value: CMTimeValue(transformedDocument.pages.count), timescale: frameDuration.timescale)
    }
}
