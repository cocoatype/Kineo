//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct ToolPickerButton: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Button(action: {
            editingState = editingState.settingToolPickerVisible()
        }, label: {
            Image(systemName: "pencil.tip.crop.circle")
        })
    }
}
