//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct CanvasLayer: View {
    static let layerDepth = 10.0

    @Binding var editingState: EditingState
    private let pageID: UUID
    private let layerID: UUID

    init(editingState: Binding<EditingState>, layer: IndexedLayer) {
        _editingState = editingState
        self.pageID = layer.page.id
        self.layerID = layer.id
    }

    var body: some View {
        CanvasViewRepresentable(drawing: editingState.document.pages[pageID].layers[layerID].drawing)
            .allowsHitTesting(false)
            .frame(depth: Self.layerDepth)
    }
}
