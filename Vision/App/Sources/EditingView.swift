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
        let _ = Self._printChanges()
            HStack(spacing: 0) {
                CanvasSidebar(editingState: $editingState, height: 0)
                DrawingView(editingState: $editingState)
                    .aspectRatio(1, contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ornament(attachmentAnchor: OrnamentAttachmentAnchor.scene(.top)) {
                EditingMenu(editingState: editingState)
            }
            .toolbarRole(.browser)
            .toolbar {
                CanvasToolbarContent(editingState: $editingState, isExporting: $isExporting)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredSurroundingsEffect(editingState.mode.isPlaying ? .systemDark : nil)
        .onAppear {
            updateWindowGeometry()
        }.onChange(of: window) { _, _ in
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
            minimumSize: CGSize(width: 640, height: 640),
            maximumSize: CGSize(width: 1024, height: 1024),
            resizingRestrictions: .uniform
        )

        mologging.requestGeometryUpdate(phoneHealthKinect)
    }
}

#Preview {
    EditingView(document: Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil))
}
