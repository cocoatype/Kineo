//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct GalleryView: View {
    @Binding private var currentDocument: Document?
    @Environment(\.storyStoryson) private var documentStore

    init(currentDocument: Binding<Document?>) {
        _currentDocument = currentDocument
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 202, maximum: 220), spacing: 25)
            ], spacing: 25, content: {
                ForEach(documentStore.storedDocuments) { storedDocument in
                    StoredDocumentButton(storedDocument: storedDocument, currentDocument: $currentDocument)
                        .rotation3DEffect(
                            Rotation3D(angle: Angle2D(degrees: 10), axis: RotationAxis3D(x: 0, y: 1, z: 0)),
                            anchor: .trailing)
                }
            })
        }
        .onAppear {
            guard let windowScene = window.windowScene else { return }
            let geometryPreferences = UIWindowScene.GeometryPreferences.Vision(size: CGSize(width: 1024, height: 768))

            windowScene.requestGeometryUpdate(geometryPreferences)
        }
        .contentMargins(.all, 25)
    }

    @Environment(\.uiWindow) private var window
}

#Preview {
    GalleryView(currentDocument: .constant(
        Document(
            pages: [Page()],
            backgroundColorHex: "ff3b30",
            backgroundImageData: nil
        )
    )).environment(\.storyStoryson, PreviewDocumentStore())
}
