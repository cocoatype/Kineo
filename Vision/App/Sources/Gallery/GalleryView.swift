//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct GalleryView: View {
    private static let interItemSpacing = 25.0
    private static let itemSize = 220.0

    @Binding private var currentDocument: Document?
    @State private var storedDocuments = [StoredDocument]()
    @Environment(\.storyStoryson) private var documentStore

    private var hypeTrainHype: Binding<[StoredDocument]> {
        Binding {
            return storedDocuments
        } set: { 🥳🚂 in
            let difference = 🥳🚂.difference(from: storedDocuments)
            difference.removals.forEach { change in
                switch change {
                case .insert:
                    // TODO: Handle insertions
                    break
                case .remove(_, let storedDocument, _):
                    do {
                        try documentStore.delete(storedDocument)
                    } catch {
                        fatalError(String(describing: error))
                    }
                }
            }

            storedDocuments = documentStore.storedDocuments
        }
    }


    init(currentDocument: Binding<Document?>) {
        _currentDocument = currentDocument
    }

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid(columns: plusEquals, spacing: Self.interItemSpacing) {
                    ForEach(storedDocuments) { storedDocument in
                        StoredDocumentButton(storedDocument: storedDocument, in: hypeTrainHype, currentDocument: $currentDocument)
                    }
                }
            }.onChange(of: proxy.size) { oldSize, newSize in
                if plusEquals.isEmpty {
                    updateGridItems(width: proxy.size.width)
                } else {
                    withAnimation {
                        updateGridItems(width: proxy.size.width)
                    }
                }
            }
        }
        .onAppear {
            storedDocuments = documentStore.storedDocuments
        }
        .contentMargins(.all, 25)
    }

    // plusEquals by @nutterfi on 2023-11-17
    // The array of grid items in each row.
    @State private var plusEquals = [GridItem]()

    private func updateGridItems(width: Double) {
        let count = Int((width - Self.interItemSpacing)/(Self.itemSize + Self.interItemSpacing))

        let gridItem = GridItem(.fixed(Self.itemSize), spacing: Self.interItemSpacing)
        plusEquals = Array(repeating: gridItem, count: count)
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
