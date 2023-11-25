//  Created by Geoff Pado on 9/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct DrawingViewLayerButton: View {
    @Binding private var editingState: EditingState
    private let layer: IndexedLayer

    init(editingState: Binding<EditingState>, layer: IndexedLayer) {
        _editingState = editingState
        self.layer = layer
    }

    var body: some View {
        let index = Double(layer.index)
        let offset = Double(index) * Self.offset2D
        Button {
            editingState = editingState
                .settingActiveLayerIndex(to: layer.index)
                .editing
        } label: {
            CanvasLayer(editingState: $editingState, layerID: layer.id)
        }
        .offset(y: offset)
        .buttonBorderShape(.roundedRectangle(radius: 16))
    }

    private static let offset2D = 60.0
}
