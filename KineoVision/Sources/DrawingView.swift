//  Created by Geoff Pado on 8/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct DrawingView: View {
    @Binding private var editingState: EditingState
    @State private var skinImage: Image? = nil
    @Environment(\.storyStoryson) private var documentStore

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ZStack {
            if editingState.mode == .editing {
                RoundedRectangle(cornerRadius: 16)
                    .glassBackgroundEffect()
                    .opacity(0.2).offset(z: -2)

                DrawingCanvas(editingState: $editingState)
//                    .background(
//                        Color(uiColor: editingState.canvasBackgroundColor)
//                    )

//                    ForEach(placements) { placement in
//                        placement
//                    }

                if let skinImage { skinImage.allowsHitTesting(false) }
            } else if case .playing = editingState.mode {
                Player(editingState: editingState)
                    .background(.white)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onChange(of: editingState) { _, newState in
            documentStore.save(newState.document)

            Task {
                let (image, skinPageIndex) = await Self.skinGenerator.generateSkinsImage(from: newState.document, currentPageIndex: newState.currentPageIndex)
                if self.editingState.currentPageIndex == skinPageIndex {
                    skinImage = Image(uiImage: image)
                }
            }
        }
    }

    private static let skinGenerator = SkinGenerator()
}
