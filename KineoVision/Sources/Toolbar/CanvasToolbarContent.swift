//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct CanvasToolbarContent: ToolbarContent {
    @Binding private var editingState: EditingState
    @Binding private var isLayerModeActive: Bool
    init(editingState: Binding<EditingState>, isLayerModeActive: Binding<Bool>) {
        _editingState = editingState
        _isLayerModeActive = isLayerModeActive
    }

    var body: some ToolbarContent {
        if editingState.toolPickerShowing == false {
            ToolbarItem(placement: .bottomOrnament) {
                Button(action: {
                    editingState = editingState.playingContinuously
                }, label: {
                    Image(systemName: "play")
                })
            }
            ToolbarItem(placement: .bottomOrnament) {
                Divider()
            }
            ToolbarItemGroup(placement: .bottomOrnament) {
                ToolPickerButton(editingState: $editingState)
                LayerButton(isLayerModeActive: $isLayerModeActive)
                ShareButton()
                InsertButton()
            }
        }
    }
}
