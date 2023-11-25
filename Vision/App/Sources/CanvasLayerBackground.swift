//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct CanvasLayerBackground: View {
    var body: some View {
        Rectangle()
            .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 16))
            .opacity(0.2)
            .offset(z: -1)
            .aspectRatio(1, contentMode: .fit)
    }
}

