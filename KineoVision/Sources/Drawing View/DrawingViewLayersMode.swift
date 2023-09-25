//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct DrawingViewLayersMode: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ZStack {
            ForEach(0..<5) { index in
                let offset = Double(index) * Self.offset2D
                Button {
                    print("selected layer at index \(index)")
                } label: {
                    CanvasLayer(editingState: $editingState)
                }
                .offset(x: 0, y: offset)
                .buttonBorderShape(.roundedRectangle(radius: 16))
            }
        }
        .offset(z: -(Double(Self.layerCount) * CanvasLayer.layerDepth))
    }

    private static let layerCount = 5
    private static let offset2D = 60.0
}
