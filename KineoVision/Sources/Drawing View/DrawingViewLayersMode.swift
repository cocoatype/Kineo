//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct DrawingViewLayersMode: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ZStack {
            ForEach(indexedLayers) { indexedLayer in
                let index = Double(indexedLayer.index)
                let offset = Double(index) * Self.offset2D
                Button {
                    editingState = editingState.settingActiveLayerIndex(to: indexedLayer.index)
                } label: {
                    CanvasLayer(editingState: $editingState, layerID: indexedLayer.id)
                }
                .offset(x: 0, y: offset)
                .buttonBorderShape(.roundedRectangle(radius: 16))
            }
        }
        .offset(z: -(Double(Self.layerCount) * CanvasLayer.layerDepth))
    }

    private var indexedLayers: [IndexedLayer] {
        editingState.currentPage.layers.enumerated().map {
            IndexedLayer(layer: $0.element, index: $0.offset)
        }
    }

    private static let layerCount = 5
    private static let offset2D = 60.0
}

struct IndexedLayer: Identifiable {
    let layer: Layer
    let index: Int
    var id: UUID { layer.id }
}
