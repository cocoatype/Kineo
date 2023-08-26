//  Created by Geoff Pado on 7/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct GalleryButton: View {
    @Environment(\.showGallery) private var showGallery

    var body: some View {
        Button {
            showGallery()
        } label: {
            Image(systemName: "square.grid.2x2")
                .resizable()
                .frame(width: 32, height: 32)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .glassBackgroundEffect(in: .rect(cornerRadius: 16))
        }
    }
}
