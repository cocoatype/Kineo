//  Created by Geoff Pado on 8/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct DrawingView: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Group {
            switch editingState.mode {
            case .editing:
                DrawingViewEditingMode(editingState: $editingState)
            case .playing:
                DrawingViewPlayingMode(editingState: editingState)
            case .scrolling:
                EmptyView()
            case .layers:
                DrawingViewLayersMode(editingState: $editingState)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
