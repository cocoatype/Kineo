//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import PencilKit

struct Player: View {
    @Binding private var editingState: EditingState
    @State private var currentPageIndex: Int
    private let displayLink = DisplayLink()

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
        _currentPageIndex = State(initialValue: editingState.wrappedValue.currentPageIndex)
    }

    private var currentDrawing: PKDrawing {
        editingState.document.pages[currentPageIndex].drawing
    }

    var body: some View {
        Canvas(drawing: currentDrawing)
            .task {
                for await _ in displayLink {
                    let playbackDocument = editingState.document
                    currentPageIndex = (currentPageIndex + 1) % playbackDocument.pages.endIndex
                }
            }
    }
}
