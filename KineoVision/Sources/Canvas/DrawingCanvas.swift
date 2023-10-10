//  Created by Geoff Pado on 9/27/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import PencilKit
import SwiftUI

struct DrawingCanvas: View {
    @Binding private var editingState: EditingState
    @State private var drawing: PKDrawing
    @State private var isToolPickerVisible: Bool
    private let layerID: UUID

    init(editingState: Binding<EditingState>, layerID: UUID) {
        _editingState = editingState
        _drawing = State(initialValue: editingState.wrappedValue.currentPage.layers[layerID].drawing)

        let wrappedState = editingState.wrappedValue
        let activeLayer = wrappedState.currentPage.layers[wrappedState.activeLayerIndex]
        let representsActiveLayer = (layerID == activeLayer.id)
        _isToolPickerVisible = State(initialValue: wrappedState.toolPickerShowing && representsActiveLayer)

        self.layerID = layerID
    }

    var body: some View {
        Canvas(drawing: $drawing, isToolPickerVisible: $isToolPickerVisible)
            .onChange(of: drawing) { _, newDrawing in
                editingState = editingState.replacingCurrentActiveDrawing(with: newDrawing)
            }.onChange(of: isToolPickerVisible) { _, newVisibility in
                editingState = editingState.settingToolPickerVisible(visible: newVisibility)
            }.onChange(of: editingState) {
                drawing = editingState.currentPage.layers[layerID].drawing
                isToolPickerVisible = editingState.toolPickerShowing && representsActiveLayer
            }
            .allowsHitTesting(representsActiveLayer)
    }

    private var representsActiveLayer: Bool {
        let activeLayer = editingState.currentPage.layers[editingState.activeLayerIndex]
        return layerID == activeLayer.id
    }
}
