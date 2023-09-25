//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct CanvasLayer: View {
    static let layerDepth = 10.0

    @Binding var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Canvas(drawing: editingState.currentPage.drawing)
            .allowsHitTesting(false)
            .frame(depth: Self.layerDepth)
    }
}
