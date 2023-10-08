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
                DrawingViewLayerButton(editingState: $editingState, layer: indexedLayer)
            }
        }
        .offset(z: -(Double(indexedLayers.count) * CanvasLayer.layerDepth))
    }

    private var indexedLayers: [IndexedLayer] {
        editingState.currentPage.layers.enumerated().map {
            IndexedLayer(layer: $0.element, index: $0.offset)
        }
    }
}
