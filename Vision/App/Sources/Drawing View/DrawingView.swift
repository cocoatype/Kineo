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
    }
}
