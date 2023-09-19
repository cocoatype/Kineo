//  Created by Geoff Pado on 7/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct GalleryButton: View {
    @Environment(\.showGallery) private var showGallery

    var body: some View {
        Button {
            showGallery()
        } label: {
            Label("GalleryButton.title", systemImage: "square.grid.2x2")
        }
    }
}
