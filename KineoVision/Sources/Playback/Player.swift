//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import PencilKit

struct Player: View {
    private let playbackDocument: Document
    @State private var currentPageIndex: Int

    init(editingState: EditingState) {
        playbackDocument = DocumentTransformer.bouncedDocument(from: editingState.document)
        _currentPageIndex = State(initialValue: editingState.currentPageIndex)
    }

    private var currentDrawing: PKDrawing {
        playbackDocument.pages[currentPageIndex].drawing
    }

    var body: some View {
        Canvas(drawing: currentDrawing)
            .allowsHitTesting(false)
            .task {
                for await _ in DisplayLink() {
                    currentPageIndex = (currentPageIndex + 1) % playbackDocument.pages.endIndex
                }
            }
    }
}
