//  Created by Geoff Pado on 8/18/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct FillButton: View {
    @Binding private var editingState: EditingState
    @State private var backgroundColor: Color

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
        _backgroundColor = State(initialValue: Color(uiColor: editingState.wrappedValue.document.canvasBackgroundColor))
    }

    var body: some View {
        ColorPicker(selection: $backgroundColor) {
            Image(systemName: "paintbrush")
        }.onChange(of: backgroundColor) { _, newColor in
            editingState = editingState.settingBackgroundColor(to: UIColor(newColor))
        }
    }
}
