//
//  ContentView.swift
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

struct ContentView: View {
    @State private var editingState: EditingState
    @State private var isLayerModeActive = false
    @State private var placements = [StickerPlacement]()

    init() {
        _editingState = State(initialValue: EditingState(document: TemporaryPersistence.persistedDocument))
    }

    @State private var isAnimating = false
    private static let fullTransform = Rotation3D(angle: Angle2D(degrees: 10), axis: .y).rotated(by: Rotation3D(angle: Angle2D(degrees: -10), axis: .x))

    var body: some View {
        GeometryReader3D { proxy in
            ZStack {
                if editingState.mode == .editing {
                    DrawingCanvas(editingState: $editingState)
                        .background(.white)
                    
                    ForEach(placements) { placement in
                        placement
                    }
                } else if case .playing = editingState.mode {
                    Player(editingState: $editingState)
                        .background(.white)
                }
            }
            .dropDestination(for: Data.self) { items, location in
                guard let firstItem = items.first,
                      let placement = StickerPlacement(data: firstItem, location: location)
                else { return false }

                placements.append(placement)
                return true
            }
            .ornament(attachmentAnchor: OrnamentAttachmentAnchor.scene(alignment: .leading)) {
                CanvasSidebar(editingState: $editingState, height: proxy.size.height)
            }
            .toolbar {
                CanvasToolbarContent(editingState: $editingState, isLayerModeActive: $isLayerModeActive)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onChange(of: editingState) {
            TemporaryPersistence.persistedDocument = $1.document
        }
    }
}

#Preview {
    ContentView()
}
