//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct CanvasToolbarContent: ToolbarContent {
    @Binding private var editingState: EditingState
    @Binding private var isLayerModeActive: Bool
    @Binding private var isExporting: Bool

    init(editingState: Binding<EditingState>, isLayerModeActive: Binding<Bool>, isExporting: Binding<Bool>) {
        _editingState = editingState
        _isLayerModeActive = isLayerModeActive
        _isExporting = isExporting
    }

    var body: some ToolbarContent {
        if editingState.toolPickerShowing == false {
            ToolbarItem(placement: .bottomOrnament) {
                PlayButton(editingState: $editingState)
            }
            ToolbarItem(placement: .bottomOrnament) {
                Divider()
            }
            ToolbarItemGroup(placement: .bottomOrnament) {
                ToolPickerButton(editingState: $editingState)
                LayerButton(isLayerModeActive: $isLayerModeActive)
                FillButton(editingState: $editingState)
                ShareButton(editingState: editingState)
                InsertButton()
            }
        }
    }
}
