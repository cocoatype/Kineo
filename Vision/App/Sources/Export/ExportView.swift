//  Created by Geoff Pado on 8/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CoreTransferable
import DataVision
import EditingStateVision
import SwiftUI

struct ExportView: View {
    init(editingState: EditingState) {
        self.editingState = editingState
    }

    var body: some View {
        ZStack {
            Color(editingState.canvasBackgroundColor)
            Player(editingState: editingState)
            ExportButtonsOverlay(editingState: editingState)
        }
        .preferredSurroundingsEffect(.systemDark)
        .toolbar(.hidden)
    }

    private let editingState: EditingState
}

#Preview {
    ExportView(editingState: EditingState(document: Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil)))
}
