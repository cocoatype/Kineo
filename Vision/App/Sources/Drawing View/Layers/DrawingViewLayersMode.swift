//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import UIKit

struct DrawingViewLayersMode: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ZStack {
            ForEach(indexedLayers) { indexedLayer in
                DrawingViewLayerButton(editingState: $editingState, layer: indexedLayer)
            }
        }
        .offset(z: -(Double(indexedLayers.count) * CanvasLayer.layerDepth))
    }

    private var indexedLayers: [IndexedLayer] {
        let page = editingState.document.pages[editingState.currentPageIndex]
        return page.layers.enumerated().map {
            IndexedLayer(page: page, layer: $0.element, index: $0.offset)
        }
    }
}

extension UIWindowSceneResizingRestrictions {
    var wtf: UIWindowScene.ResizingRestrictions? {
        switch self {
        case .unspecified:
            return nil
        case .none:
            return UIWindowScene.ResizingRestrictions.none
        case .uniform:
            return .uniform
        case .freeform:
            return .freeform
        @unknown default:
            return nil
        }
    }
}
