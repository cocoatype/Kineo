//  Created by Geoff Pado on 10/8/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ExistingPageItemThumbnail: View {
    private let image: Image
    init(image: Image) {
        self.image = image
    }

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
