//  Created by Geoff Pado on 8/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct NewPageButton: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Button {
            editingState = editingState.addingNewPage()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 32, height: 32)
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonBorderShape(.roundedRectangle(radius: 0))
        .aspectRatio(1, contentMode: .fill)
    }
}
