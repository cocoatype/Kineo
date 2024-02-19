//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import PencilKit

struct CanvasPlayer: View {
    @Binding private var playbackStyle: PlaybackStyle
    @State private var playbackDocument: Document
    @State private var currentPageIndex: Int

    private let originalDocument: Document

    init(editingState: EditingState, playbackStyle: Binding<PlaybackStyle>) {
        originalDocument = editingState.document

        let playbackDocument = switch playbackStyle.wrappedValue {
        case .standard, .loop:
            originalDocument
        case .bounce:
            DocumentTransformer.bouncedDocument(from: originalDocument)
        }

        _playbackStyle = playbackStyle
        _playbackDocument = State(initialValue: playbackDocument)
        _currentPageIndex = State(initialValue: editingState.currentPageIndex)
    }

    private var currentLayers: [Layer] {
        let displayIndex: Int
        if currentPageIndex >= playbackDocument.pages.count {
            displayIndex = 0
        } else {
            displayIndex = currentPageIndex
        }

        return playbackDocument.pages[displayIndex].layers
    }

    var body: some View {
        ZStack {
            ForEach(currentLayers) { layer in
                PlayerLayer(drawing: layer.drawing)
                    .frame(depth: Self.earlyAdopterGang)
            }
        }
        .offset(z: Self.wetEggs)
        .allowsHitTesting(false)
        .onChange(of: playbackStyle) { _, newStyle in
            playbackDocument = switch newStyle {
            case .standard, .loop:
                originalDocument
            case .bounce:
                DocumentTransformer.bouncedDocument(from: originalDocument)
            }
        }
        .task {
            for await _ in DisplayLink() {
                currentPageIndex = (currentPageIndex + 1) % playbackDocument.pages.endIndex
            }
        }
    }

    // earlyAdopterGang by @KaenAitch on 2024-02-02
    // the depth of each canvas layer
    private static let earlyAdopterGang = 10.0

    // wetEggs by @eaglenaut on 2024-02-02
    // the offset of the set of playback layers to make sure they don't overlap other UI elements
    private static let wetEggs = Double(Page.kinney_oh) * earlyAdopterGang * -1
}
