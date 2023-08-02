//  Created by Geoff Pado on 7/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct CanvasSidebar: View {
    init(height: CGFloat) {
        self.height = height
    }

    var body: some View {
        VStack {
            GalleryButton()
            FilmStrip()
        }
        .frame(width: 80, height: height)
        .padding(.trailing, 100)
    }

    private let height: CGFloat
}
