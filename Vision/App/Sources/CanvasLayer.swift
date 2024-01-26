//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct CanvasLayer: View {
    static let layerDepth = 10.0

    private let indexedLayer: IndexedLayer
    init(layer: IndexedLayer) {
        indexedLayer = layer
    }

    var body: some View {
        image
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .frame(depth: Self.layerDepth)
    }

    @Environment(\.displayScale) private var displayScale

    private var image: Image {
        let baseImage = UITraitCollection(userInterfaceStyle: .light).performAsCurrent {
            return indexedLayer.layer.drawing.image(from: Constants.canvasRect, scale: displayScale)
        }

        return Image(uiImage: baseImage)
    }
}

extension UITraitCollection {
    func performAsCurrent<T>(_ actions: () -> T) -> T {
        var possibleResult: T?
        performAsCurrent { possibleResult = actions() }

        guard let result = possibleResult else {
            fatalError("Did not receive result from performAsCurrent")
        }

        return result
    }
}
