//  Created by Geoff Pado on 1/24/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct ExistingPageDuplicateButton: View {
    @Binding private var editingState: EditingState
    private let page: Page

    init(_ page: Page, in editingState: Binding<EditingState>) {
        self.page = page
        _editingState = editingState
    }

    var body: some View {
        Button {
            editingState = editingState.duplicating(page)
        } label: {
            Label("ExistingPageDuplicateButton.title", systemImage: "plus.square.on.square")
        }
    }
}
