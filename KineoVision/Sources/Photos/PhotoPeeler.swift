//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI
import SwiftUIIntrospect
import UIKit
import VisionKit

struct PhotoPeeler: View {
    var body: some View {
        ZStack(alignment: .center) {
            Image(.mocha)
                .resizable()
                .aspectRatio(contentMode: .fill)
            Image(.mochaCutout)
                .position(x: 467, y: 454)
                .draggable(Image(.mochaCutout))
        }
    }
}
