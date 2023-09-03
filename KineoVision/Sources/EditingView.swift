//
//  EditingView.swift
//  KineoVision
//
//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.
//

import Combine
import DataVision
import EditingStateVision
import PencilKit
import SwiftUI

struct EditingView: View {
    @State private var editingState: EditingState
    @State private var isLayerModeActive = false
    @State private var placements = [StickerPlacement]()
    @State private var isExporting = false

    init(document: Document) {
        _editingState = State(initialValue: EditingState(document: document))
    }

    @State private var isAnimating = false
    private static let fullTransform = Rotation3D(angle: Angle2D(degrees: 10), axis: .y)

    var body: some View {
        GeometryReader3D { proxy in
            ZStack {
                DrawingView(editingState: $editingState).frame(depth: 60)
            }
//            .dropDestination(for: Data.self) { items, location in
//                guard let firstItem = items.first,
//                      let placement = StickerPlacement(data: firstItem, location: location)
//                else { return false }
//
//                placements.append(placement)
//                return true
//            }
            .ornament(attachmentAnchor: OrnamentAttachmentAnchor.scene(alignment: .leading)) {
                CanvasSidebar(editingState: $editingState, height: proxy.size.height)
            }
            .toolbar {
                CanvasToolbarContent(editingState: $editingState, isLayerModeActive: $isLayerModeActive, isExporting: $isExporting)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .sheet(isPresented: $isExporting) {
            ExportView(editingState: editingState)
        }
        .introspect(.window, on: .iOS(.v17)) { window in
            // mologging by @CompileSwift on 7/31/23
            // the window scene of the main window
            guard let mologging = window.windowScene else { return }

            // phoneHealthKinect by @nutterfi on 7/28/23
            // the geometry that fixes the main window to a square
            let phoneHealthKinect = UIWindowScene.GeometryPreferences.Vision(resizingRestrictions: .uniform)

            mologging.requestGeometryUpdate(phoneHealthKinect)
        }
    }
}

#Preview {
    EditingView(document: Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil))
}
