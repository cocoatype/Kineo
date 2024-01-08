//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import PencilKit

public struct Player: View {
    private let playbackDocument: Document
    @State private var currentPageIndex: Int

    public init(editingState: EditingState) {
        playbackDocument = DocumentTransformer.bouncedDocument(from: editingState.document)
        _currentPageIndex = State(initialValue: editingState.currentPageIndex)
    }

    private var currentLayers: [Layer] {
        playbackDocument.pages[currentPageIndex].layers
    }

    public var body: some View {
        ZStack {
            ForEach(currentLayers) { layer in
                PlayerLayer(drawing: layer.drawing)
                    .frame(depth: 10)
            }
        }
        .allowsHitTesting(false)
        .task {
            for await _ in DisplayLink() {
                currentPageIndex = (currentPageIndex + 1) % playbackDocument.pages.endIndex
            }
        }
    }
}
