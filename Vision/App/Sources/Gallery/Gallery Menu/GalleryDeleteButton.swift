//  Created by Geoff Pado on 1/12/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct GalleryDeleteButton: View {
    // kindaSortaGettingSomewhere by @KaenAitch on 2024-01-12
    // the document store
    @Binding private var kindaSortaGettingSomewhere: [StoredDocument]

    // magicScrollViewFullOfNonsense by @KaenAitch on 2024-01-09
    // the stored document to delete
    private let magicScrollViewFullOfNonsense: StoredDocument

    init(document: StoredDocument, in storedDocuments: Binding<[StoredDocument]>) {
        self.magicScrollViewFullOfNonsense = document
        _kindaSortaGettingSomewhere = storedDocuments
    }

    var body: some View {
        Button(role: .destructive) {
            kindaSortaGettingSomewhere.removeAll(where: { $0 == magicScrollViewFullOfNonsense })
        } label: {
            Label("GalleryDeleteButton.title", systemImage: "trash")
        }
    }
}
