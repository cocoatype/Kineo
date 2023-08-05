//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Page: Codable, Equatable, Identifiable {
    public init(drawing: PKDrawing? = nil, uuid: UUID = UUID()) {
        self.drawing = drawing ?? PKDrawing()
        self.uuid = uuid
    }

    public let drawing: PKDrawing
    var hasDrawing: Bool { return drawing.bounds.size != .zero }

    private let uuid: UUID
    public var id: UUID { uuid }

    public static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
