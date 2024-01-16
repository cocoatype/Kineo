//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct StoredDocumentButton: View {
    @Binding private var currentDocument: Document?
    @Binding private var storedDocuments: [StoredDocument]
    private let storedDocument: StoredDocument

    init(
        storedDocument: StoredDocument,
        in storedDocuments: Binding<[StoredDocument]>,
        currentDocument: Binding<Document?>
    ) {
        self.storedDocument = storedDocument
        _storedDocuments = storedDocuments
        _currentDocument = currentDocument
    }

    var body: some View {
        Button {
            do {
                currentDocument = try storedDocument.document
            } catch {
                fatalError(String(describing: error))
            }
        } label: {
            AsyncImage(url: storedDocument.imagePreviewURL) {
                $0.resizable()
            } placeholder: {
                Color(.canvasBackground).opacity(0.6)
            }
            .clipShape(RoundedRectangle(cornerRadius: Self.cornerRadius))
            .aspectRatio(1, contentMode: .fill)
        }
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: Self.cornerRadius))
        .contextMenu {
            GalleryDeleteButton(document: storedDocument, in: $storedDocuments)
        }
        .aspectRatio(1, contentMode: .fill)
        .buttonBorderShape(.roundedRectangle(radius: Self.cornerRadius))
        .hoverEffect(.lift)
    }

    private static let cornerRadius: Double = 25
}
