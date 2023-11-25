//  Created by Geoff Pado on 9/16/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI
import ToolbarVision

struct EditingMenu: View {
    private let editingState: EditingState

    init(editingState: EditingState) {
        self.editingState = editingState
    }

    var body: some View {
        Menu {
            ShareButton(editingState: editingState)
            GalleryButton()
        } label: {
            Image(systemName: "square.and.arrow.up")
        }
        .menuStyle(.button)
        .padding(.bottom, 80)
    }
}
