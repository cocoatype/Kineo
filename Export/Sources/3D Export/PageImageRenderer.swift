//  Created by Geoff Pado on 9/29/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import PencilKit
import UIKit

enum PageImageRenderer {
    static let disparity: Double = 5.0
    static func image(for page: Page, eye: Eye) -> UIImage {
        page.layers.reversed().enumerated().reduce(PKDrawing()) { currentDrawing, enumeratedLayer in
            let translation = CGFloat(enumeratedLayer.offset) * disparity * eye.offset
            print(translation)
            return currentDrawing.appending(
                enumeratedLayer.element.drawing.transformed(
                    using: CGAffineTransform(
                        translationX: translation,
                        y: 0
                    )
                )
            )
        }
        .image(from: VideoExporter3D.standardCanvasRect, scale: 1)
    }
}
