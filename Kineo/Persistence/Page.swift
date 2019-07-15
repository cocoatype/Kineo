//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

struct Page: Codable {
    init(drawing: PKDrawing? = nil) {
        self.drawing = drawing ?? PKDrawing()
    }

    let drawing: PKDrawing
}
