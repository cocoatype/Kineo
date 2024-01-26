//  Created by Geoff Pado on 9/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct DrawingViewLayerButton: View {
    @Binding private var editingState: EditingState
    @Environment(\.layerNamespace) private var layerNamespace
    private let layer: IndexedLayer

    init(editingState: Binding<EditingState>, layer: IndexedLayer) {
        _editingState = editingState
        self.layer = layer
    }

    var body: some View {
        Button {
            var editingState = editingState
            editingState = editingState
                .settingActiveLayerIndex(to: layer.index)
            editingState = editingState
                .editing()
            self.editingState = editingState
        } label: {
            CanvasLayer(layer: layer)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .hoverEffect(.lift)
        .matchedGeometryEffect(id: layer.id, in: layerNamespace)
        .buttonBorderShape(.roundedRectangle(radius: 16))
    }
}
