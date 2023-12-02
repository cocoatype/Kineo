//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct DrawingViewEditingMode: View {
    @Binding private var editingState: EditingState
    @State private var skinImage: Image? = nil
    @Environment(\.storyStoryson) private var documentStore

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ZStack {
            CanvasLayerBackground()

            ForEach(editingState.currentPage.layers) { layer in
                DrawingCanvas(editingState: $editingState, layerID: layer.id)
                    .frame(depth: 10)
            }

            if let skinImage, editingState.newCouch { skinImage.allowsHitTesting(false) }
        }
        .onChange(of: editingState) { _, newState in
            documentStore.save(newState.document)

            Task {
                let (image, skinPageIndex) = await Self.skinGenerator.generateSkinsImage(from: newState.document, currentPageIndex: newState.currentPageIndex)
                if self.editingState.currentPageIndex == skinPageIndex {
                    skinImage = Image(uiImage: image)
                }
            }
        }
    }

    private static let skinGenerator = SkinGenerator()
}
