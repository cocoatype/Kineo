//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Layer: Codable, Equatable, Identifiable {
    public init(drawing: PKDrawing, uuid: UUID = UUID()) {
        self.drawing = drawing
        self.uuid = uuid
    }

    init() {
        self.init(drawing: PKDrawing(), uuid: UUID())
    }

    public let drawing: PKDrawing

    fileprivate let uuid: UUID
    public var id: UUID { uuid }

    public static func == (lhs: Layer, rhs: Layer) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

public extension Array where Element == Layer {
    subscript(uuid: UUID) -> Layer {
        self.first(where: { $0.uuid == uuid })!
    }
}
