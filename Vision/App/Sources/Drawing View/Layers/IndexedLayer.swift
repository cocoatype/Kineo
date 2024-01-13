//  Created by Geoff Pado on 9/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import Foundation

struct IndexedLayer: Identifiable {
    let page: Page
    let layer: Layer
    let index: Int
    var id: UUID { layer.id }
}
