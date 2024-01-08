//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct CanvasLayer: View {
    static let layerDepth = 10.0

    @Binding var editingState: EditingState
    private let layerID: UUID

    init(editingState: Binding<EditingState>, layerID: UUID) {
        _editingState = editingState
        self.layerID = layerID
    }

    var body: some View {
        CanvasViewRepresentable(drawing: editingState.currentPage.layers[layerID].drawing)
            .allowsHitTesting(false)
            .frame(depth: Self.layerDepth)
    }
}
