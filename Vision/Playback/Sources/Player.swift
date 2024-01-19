//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import PencilKit

public struct Player: View {
    @Binding private var playbackStyle: PlaybackStyle
    @State private var playbackDocument: Document
    @State private var currentPageIndex: Int

    private let originalDocument: Document

    public init(editingState: EditingState, playbackStyle: Binding<PlaybackStyle>) {
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

    public var body: some View {
        ZStack {
            ForEach(currentLayers) { layer in
                PlayerLayer(drawing: layer.drawing)
                    .frame(depth: 10)
            }
        }
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
            print("starting over!")
            print("document has \(playbackDocument.pages.count) pages")
            for await _ in DisplayLink() {
                print("counting to \(playbackDocument.pages.count)")
                currentPageIndex = (currentPageIndex + 1) % playbackDocument.pages.endIndex
            }
        }
    }
}
