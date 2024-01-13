//  Created by Geoff Pado on 7/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import FilmStripVision
import SwiftUI

struct CanvasSidebar: View {
    init(editingState: Binding<EditingState>, height: CGFloat) {
        _editingState = editingState
        self.height = height
    }

    var body: some View {
        FilmStrip(editingState: $editingState)
    }

    @Binding private var editingState: EditingState
    private let height: CGFloat
}
