//  Created by Geoff Pado on 12/18/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import PencilKit
import SwiftUI

struct DisplayCanvas: View {
    private let drawing: PKDrawing
    init(editingState: Binding<EditingState>, layerID: UUID) {
        self.drawing = editingState.wrappedValue.currentPage.layers[layerID].drawing
    }

    var body: some View {
        CanvasViewRepresentable(drawing: drawing)
            .allowsHitTesting(false)
    }
}
