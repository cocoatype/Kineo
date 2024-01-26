//  Created by Geoff Pado on 7/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct LayerButton: View {
    @Binding private var editingState: EditingState
    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Button {
            if isSelected {
                editingState = editingState.editing()
            } else {
                editingState = editingState.layers()
            }
        } label: {
            Image(systemName: "square.2.stack.3d.bottom.fill")
        }
        .background(isSelected ? Color.white.clipShape(Capsule()) : nil)
        .foregroundStyle(isSelected ? Color.black : Color.white)
    }

    private var isSelected: Bool {
        editingState.mode == .layers
    }
}
