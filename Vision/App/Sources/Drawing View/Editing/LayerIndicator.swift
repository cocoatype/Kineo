//  Created by Geoff Pado on 1/24/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct LayerIndicator: View {
    private static let size: Double = 20
    private let editingState: EditingState

    init(editingState: EditingState) {
        self.editingState = editingState
    }

    var body: some View {
        VStack {
            ForEach(editingState.document.pages[editingState.currentPageIndex].layers) { layer in
                Circle()
                    .fill(layer.id == editingState.currentPage.layers[editingState.activeLayerIndex].id ? Color.white : Color.clear)
                    .frame(width: Self.size, height: Self.size)
                    .glassBackgroundEffect()
            }
        }
    }
}
