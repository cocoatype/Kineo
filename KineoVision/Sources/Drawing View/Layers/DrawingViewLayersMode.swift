//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import UIKit

struct DrawingViewLayersMode: View {
    @Binding private var editingState: EditingState
    @Environment(\.uiWindow) private var window
    @State private var previousSize: CGSize?
    @State private var previousGeometry: UIWindowScene.Geometry?

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
        .onAppear {
            guard let windowScene = window.windowScene else { return }
            previousGeometry = windowScene.effectiveGeometry
            previousSize = window.bounds.size

            let geometryPreferences = UIWindowScene.GeometryPreferences.Vision(
                size: CGSize(width: 912, height: 912),
                resizingRestrictions: UIWindowScene.ResizingRestrictions.none
            )

            windowScene.requestGeometryUpdate(geometryPreferences)
        }.onDisappear {
            guard let previousGeometry,
                  let previousSize,
                  let windowScene = window.windowScene
            else { return }

            let geometryPreferences = UIWindowScene.GeometryPreferences.Vision(size: previousSize, resizingRestrictions: previousGeometry.resizingRestrictions.wtf)

            windowScene.requestGeometryUpdate(geometryPreferences)
        }
    }

    private var indexedLayers: [IndexedLayer] {
        editingState.currentPage.layers.enumerated().map {
            IndexedLayer(layer: $0.element, index: $0.offset)
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
