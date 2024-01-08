//  Created by Geoff Pado on 8/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct DrawingView: View {
    @Namespace private var namespace
    @Binding private var editingState: EditingState
    @Environment(\.uiWindow) private var window
    @State private var previousSize: CGSize?
    @State private var previousGeometry: UIWindowScene.Geometry?

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Group {
            switch editingState.mode {
            case .editing:
                DrawingViewEditingMode(editingState: $editingState)
            case .playing:
                DrawingViewPlayingMode(editingState: editingState)
            case .layers:
                DrawingViewLayersMode(editingState: $editingState)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .environment(\.layerNamespace, namespace)
        .onChange(of: editingState.mode) { _, newMode in
            guard let windowScene = window.windowScene else { return }

            switch newMode {
            case .layers:
                previousGeometry = windowScene.effectiveGeometry
                previousSize = window.bounds.size

                let geometryPreferences = UIWindowScene.GeometryPreferences.Vision(
                    size: CGSize(width: 912, height: 972),
                    resizingRestrictions: UIWindowScene.ResizingRestrictions.none
                )

                windowScene.requestGeometryUpdate(geometryPreferences)
            case .editing, .playing:
                guard let previousGeometry,
                      let previousSize
                else { return }

                let geometryPreferences = UIWindowScene.GeometryPreferences.Vision(size: previousSize, resizingRestrictions: previousGeometry.resizingRestrictions.wtf)

                windowScene.requestGeometryUpdate(geometryPreferences)
            }
        }
    }
}
