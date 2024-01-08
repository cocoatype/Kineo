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
        let offset = Double(index - 2) * Self.offset2D
        Button {
            var editingState = editingState
            editingState = editingState
                .settingActiveLayerIndex(to: layer.index)
            editingState = editingState
                .editing()
            self.editingState = editingState
        } label: {
            CanvasLayer(editingState: $editingState, layerID: layer.id)
        }
        .hoverEffect(.lift)
        .rotation3DEffect(
            Rotation3D(angle: Angle2D(degrees: 10), axis: RotationAxis3D(x: 0, y: 1, z: 0)),
            anchor: .trailing)
        .frame(width: 512, height: 512)
        .offset(x: offset, y: offset - 30)
        .buttonBorderShape(.roundedRectangle(radius: 16))
    }

    private static let offset2D = 100.0
}
