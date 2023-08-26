//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct RootView: View {
    @State var currentDocument: Document?

    init(currentDocument: Document? = nil) {
        _currentDocument = State(initialValue: currentDocument)
    }

    var body: some View {
        if let currentDocument {
            EditingView(document: currentDocument)
                .environment(\.showGallery, ShowGalleryAction {
                    self.currentDocument = nil
                })
        } else {
            GalleryView(currentDocument: $currentDocument)
        }
    }
}
