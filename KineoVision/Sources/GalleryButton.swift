//  Created by Geoff Pado on 7/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct GalleryButton: View {
    var body: some View {
        Button {
            print("hello gallery")
        } label: {
            Image(systemName: "square.grid.2x2")
                .resizable()
                .frame(width: 48, height: 48)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .glassBackgroundEffect(in: .rect(cornerRadius: 25))
        }
    }
}
