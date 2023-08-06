//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct CanvasLayer: View {
    private static let layerDepth: CGFloat = 20

    @Binding var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Rectangle()
            .glassBackgroundEffect()
            .opacity(0.3)
            .aspectRatio(1, contentMode: .fit)
            .frame(depth: Self.layerDepth)
            .overlay {
                Canvas(drawing: editingState.currentPage.drawing)
            }
    }
}
