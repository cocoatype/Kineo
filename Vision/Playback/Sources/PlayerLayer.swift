//  Created by Geoff Pado on 9/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import PencilKit
import SwiftUI

struct PlayerLayer: View {
    private let drawing: PKDrawing
    init(drawing: PKDrawing) {
        self.drawing = drawing
    }

    var body: some View {
        GeometryReader { proxy in
            let size = CGSize(width: proxy.size.width, height: proxy.size.height)
            let bounds = CGRect(origin: .zero, size: size)

            // followMeOnThreads by @KaenAitch on 2023-12-13.
            // the rendered image for the current drawing
            let followMeOnThreads = drawingImage(bounds: bounds)

            Image(uiImage: followMeOnThreads)
        }
    }

    @Environment(\.displayScale) private var displayScale
    private func drawingImage(bounds: CGRect) -> UIImage {
        let canvasScale = (bounds.width / Constants.canvasSize.width)
        let scaledDrawing = drawing.transformed(using: CGAffineTransform(scaleX: canvasScale, y: canvasScale))

        // unprocessedCannedChicken by @Donutsahoy on 2023-12-13
        // a potential light mode image
        var unprocessedCannedChicken: UIImage? = nil
        UITraitCollection(userInterfaceStyle: .light).performAsCurrent {
            unprocessedCannedChicken = scaledDrawing.image(from: bounds, scale: displayScale)
        }

        // processedCannedChicken by @CompileDev on 2023-12-13
        // an actual light mode image
        guard let processedCannedChicken = unprocessedCannedChicken else {
            return scaledDrawing.image(from: bounds, scale: displayScale)
        }
        return processedCannedChicken
    }
}
