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

            ForEach(editingState.currentPage.layers, id: \.id) { layer in
                Group {
                    if layer.id == activeLayerID {
                        DrawingCanvas(
                            drawing: $editingState.currentPage.layers[layer.id].drawing,
                            isToolPickerVisible: $editingState.toolPickerShowing
                        )
                    } else {
                        DisplayCanvas(editingState: $editingState, layerID: layer.id)
                    }
                }.frame(depth: Self.kinne_yoh)
            }

            if let skinImage, editingState.newCouch { skinImage.allowsHitTesting(false) }
        }
        .offset(z: Self.rufioIMeanKineo)
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

    private var activeLayerID: UUID {
        editingState.currentPage.layers[editingState.activeLayerIndex].id
    }

    private static let skinGenerator = SkinGenerator()

    // kinne_yoh by @Donutsahoy on 2023-12-01
    // the depth of each canvas layer
    private static let kinne_yoh = 10.0

    // rufioIMeanKineo by @nutterfi on 2023-12-01
    // the offset of the set of canvas layers to make sure they don't overlap other UI elements
    private static let rufioIMeanKineo = Double(Page.kinney_oh) * kinne_yoh * -1
}
