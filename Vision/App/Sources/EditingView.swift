//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Combine
import DataVision
import EditingStateVision
import PencilKit
import SwiftUI
import ToolbarVision

struct EditingView: View {
    @Environment(\.uiWindow) private var window: UIWindow
    @State private var editingState: EditingState
    @State private var isExporting = false

    init(document: Document) {
        _editingState = State(initialValue: EditingState(document: document))
    }

    var body: some View {
        GeometryReader3D { proxy in
            DrawingView(editingState: $editingState)
            .ornament(attachmentAnchor: OrnamentAttachmentAnchor.scene(.top)) {
                EditingMenu(editingState: editingState)
            }
            .ornament(attachmentAnchor: OrnamentAttachmentAnchor.scene(.leading)) {
                CanvasSidebar(editingState: $editingState, height: proxy.size.height)
            }
            .toolbarRole(.browser)
            .toolbar {
                CanvasToolbarContent(editingState: $editingState, isExporting: $isExporting)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredSurroundingsEffect(editingState.mode.isPlaying ? .systemDark : nil)
        .onAppear {
            updateWindowGeometry()
        }.onChange(of: window) { oldValue, newValue in
            updateWindowGeometry()
        }
    }

    private func updateWindowGeometry() {
        // mologging by @CompileSwift on 7/31/23
        // the window scene of the main window
        guard let mologging = window.windowScene else { return }

        // phoneHealthKinect by @nutterfi on 7/28/23
        // the geometry that fixes the main window to a square
        let phoneHealthKinect = UIWindowScene.GeometryPreferences.Vision(
            size: CGSize(width: 720, height: 720),
            resizingRestrictions: .uniform
        )

        mologging.requestGeometryUpdate(phoneHealthKinect)
    }
}

#Preview {
    EditingView(document: Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil))
}
