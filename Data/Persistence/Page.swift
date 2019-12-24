//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Page: Codable, Equatable {
    public init(drawing: PKDrawing? = nil) {
        self.drawing = drawing ?? PKDrawing()
    }

    public let drawing: PKDrawing
    var hasDrawing: Bool { return drawing.bounds.size != .zero }

    public static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.drawing == rhs.drawing
    }
}
