//  Created by Geoff Pado on 9/29/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import PencilKit
import UIKit

@available(iOS 17.0, *)
enum PageImageRenderer {
    static let disparity: Double = -2.0
    static func image(for page: Page, eye: Eye) -> UIImage {
        page.layers.enumerated().reduce(PKDrawing()) { currentDrawing, enumeratedLayer in
            let translation = CGFloat(enumeratedLayer.offset) * disparity * eye.offset
            return currentDrawing.appending(
                enumeratedLayer.element.drawing.transformed(
                    using: CGAffineTransform(
                        translationX: translation,
                        y: 0
                    )
                )
            )
        }
        .image(from: VideoGenerationConstants.standardCanvasRect, scale: 1)
    }
}
