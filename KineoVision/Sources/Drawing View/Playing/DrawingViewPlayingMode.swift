//  Created by Geoff Pado on 9/27/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct DrawingViewPlayingMode: View {
    private let editingState: EditingState

    init(editingState: EditingState) {
        self.editingState = editingState
    }

    var body: some View {
        Player(editingState: editingState)
            .preferredSurroundingsEffect(.systemDark)
    }
}
