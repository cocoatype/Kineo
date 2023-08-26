//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct StoredDocumentButton: View {
    @Binding private var currentDocument: Document?
    private let storedDocument: StoredDocument

    init(storedDocument: StoredDocument, currentDocument: Binding<Document?>) {
        self.storedDocument = storedDocument
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
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .aspectRatio(1, contentMode: .fit)
            } placeholder: {
                Color(.canvasBackground).opacity(0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .aspectRatio(1, contentMode: .fit)
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .aspectRatio(1, contentMode: .fit)
        }
        .buttonBorderShape(.roundedRectangle(radius: 25))
        .aspectRatio(1, contentMode: .fill)
        .hoverEffect(.lift)
    }
}
