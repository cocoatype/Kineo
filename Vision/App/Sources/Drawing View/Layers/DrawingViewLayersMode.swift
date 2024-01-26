//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import Spatial
import SwiftUI
import UIKit

struct DrawingViewLayersMode: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    @State var isRotated = false
    var body: some View {
        ZStack {
            ForEach(indexedLayers) { indexedLayer in
                let index = Double(indexedLayer.index)
                let offset = Double(index - 2) * Self.offset2D
                DrawingViewLayerButton(editingState: $editingState, layer: indexedLayer)
                    .rotation3DEffect(
                        isRotated ? Self.rotation : .identity,
                        anchor: .trailing)
                    .scaleEffect(isRotated ? Self.smallScale : Self.defaultScale)
                    .offset(
                        x: isRotated ? offset : 0.0,
                        y: isRotated ? offset - 20 : 0.0
                    )

            }
        }
        .offset(z: -(Double(indexedLayers.count) * CanvasLayer.layerDepth))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            withAnimation {
                isRotated = true
            }
        }
    }

    private var indexedLayers: [IndexedLayer] {
        let page = editingState.document.pages[editingState.currentPageIndex]
        return page.layers.enumerated().map {
            IndexedLayer(page: page, layer: $0.element, index: $0.offset)
        }
    }

    private static let offset2D = 100.0

    private static let rotation = Rotation3D(angle: Angle2D(degrees: 10), axis: RotationAxis3D(x: 0, y: 1, z: 0))
    private static let smallScale = CGSize(width: 0.4, height: 0.4)
    private static let defaultScale = CGSize(width: 1.0, height: 1.0)
}
