//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct CanvasToolbarContent: ToolbarContent {
    @Binding private var editingState: EditingState
    @Binding private var isExporting: Bool

    init(editingState: Binding<EditingState>, isExporting: Binding<Bool>) {
        _editingState = editingState
        _isExporting = isExporting
    }

    var body: some ToolbarContent {
        if editingState.toolPickerShowing == false {
            ToolbarItemGroup(placement: .bottomOrnament) {
                UndoButton()
                RedoButton()
            }
            ToolbarItem(placement: .bottomOrnament) {
                Divider()
            }
            ToolbarItem(placement: .bottomOrnament) {
                PlayButton(editingState: $editingState)
            }
            ToolbarItem(placement: .bottomOrnament) {
                Divider()
            }
            ToolbarItemGroup(placement: .bottomOrnament) {
                ToolPickerButton(editingState: $editingState)
                LayerButton(editingState: $editingState)
                FillButton(editingState: $editingState)
                ShareButton(editingState: editingState)
            }
        }
    }
}
