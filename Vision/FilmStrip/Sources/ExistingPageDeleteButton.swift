//  Created by Geoff Pado on 1/24/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct ExistingPageDeleteButton: View {
    @Binding private var editingState: EditingState
    private let page: Page

    init(_ page: Page, in editingState: Binding<EditingState>) {
        self.page = page
        _editingState = editingState
    }

    var body: some View {
        Button(role: .destructive) {
            editingState = editingState.removing(page)
        } label: {
            Label("ExistingPageDeleteButton.title", systemImage: "trash")
        }
    }
}
