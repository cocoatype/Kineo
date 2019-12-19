//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Page: Codable {
    public init(drawing: PKDrawing? = nil) {
        self.drawing = drawing ?? PKDrawing()
    }

    public let drawing: PKDrawing
    var hasDrawing: Bool { return drawing.bounds.size != .zero }
}
