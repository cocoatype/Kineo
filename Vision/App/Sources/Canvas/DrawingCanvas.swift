//  Created by Geoff Pado on 9/27/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import OSLog
import PencilKit
import SwiftUI

struct DrawingCanvas: View {
    @Binding private var drawing: PKDrawing
    @Binding private var isToolPickerVisible: Bool

    init(drawing: Binding<PKDrawing>, isToolPickerVisible: Binding<Bool>) {
        os_log("new drawing canvas")
        _drawing = drawing
        _isToolPickerVisible = isToolPickerVisible
    }

    var body: some View {
        CanvasViewRepresentable(
            drawing: $drawing,
            isToolPickerVisible: $isToolPickerVisible
        )
    }
}
