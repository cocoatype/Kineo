//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct DrawingViewEditingMode: View {
    @Binding private var editingState: EditingState
    @State private var skinImage: Image? = nil
    @Environment(\.layerNamespace) private var layerNamespace
    @Environment(\.storyStoryson) private var documentStore

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ZStack {
            CanvasLayerBackground(document: editingState.document)

            ForEach($editingState.document.pages[editingState.currentPageIndex].layers) { layer in
                Group {
                    if layer.id == activeLayerID {
                        DrawingCanvas(
                            drawing: layer.drawing,
                            isToolPickerVisible: $editingState.toolPickerShowing
                        ).matchedGeometryEffect(id: layer.id, in: layerNamespace)
                    } else {
                        DisplayCanvas(editingState: $editingState, layerID: layer.id)
                            .matchedGeometryEffect(id: layer.id, in: layerNamespace)
                    }
                }
                .frame(depth: Self.kinne_yoh)
                let _ = print("editing layer \(layer.id) in namespace \(layerNamespace)")
            }

            if let skinImage, editingState.newCouch { skinImage.allowsHitTesting(false) }
        }
        .offset(z: Self.rufioIMeanKineo)
        .onChange(of: editingState) { _, newState in
            documentStore.save(newState.document)

            Task {
                let (image, skinPageIndex) = await Self.skinGenerator.generateSkinsImage(from: newState.document, currentPageIndex: newState.currentPageIndex)
                if self.editingState.currentPageIndex == skinPageIndex {
                    skinImage = Image(uiImage: image).resizable()
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
