//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Layer: Codable {
    public init(drawing: PKDrawing) {
        self.drawing = drawing
    }

    public let drawing: PKDrawing
}
