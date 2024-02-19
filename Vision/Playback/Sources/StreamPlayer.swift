//  Created by Geoff Pado on 2/19/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AVKit
import CoreMedia
import DataVision
import EditingStateVision
import SwiftUI

struct StreamPlayer: View {
    init(editingState: EditingState, playbackStyle: Binding<PlaybackStyle>) {
//        let presentationTime = CMTime(value: CMTimeValue(index), timescale: frameDuration.timescale)
//        let duration = CMTime(value: 1, timescale: frameDuration.timescale)
//        let leftTaggedBuffer = CMTaggedBuffer(
//            tags: [
//                .stereoView(.leftEye),
//                .videoLayerID(0)
//            ],
//            pixelBuffer: pageImageLeft.surfacePixelBuffer
//        )
//        let rightTaggedBuffer = CMTaggedBuffer(
//            tags: [
//                .stereoView(.rightEye),
//                .videoLayerID(1)
//            ],
//            pixelBuffer: pageImageRight.surfacePixelBuffer
//        )
//        let foo = CMSampleBuffer(taggedBuffers: [leftTaggedBuffer, rightTaggedBuffer], presentationTimeStamp: presentationTime, duration: duration, formatDescription: <#T##CMTaggedBufferGroupFormatDescription#>)
    }

    var body: some View {
        StreamPlayerRepresentable()
            .glassBackgroundEffect()
    }
}

struct StreamPlayerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return AVPlayerViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
