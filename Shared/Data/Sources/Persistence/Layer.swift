//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Layer: Codable, Equatable, Identifiable {
    public init(drawing: PKDrawing, uuid: UUID = UUID()) {
        self.init(drawingData: drawing.dataRepresentation(), uuid: uuid)
    }

    init(drawingData: Data, uuid: UUID = UUID()) {
        self.drawingData = drawingData
        self.uuid = uuid
    }

    init() {
        self.init(drawing: PKDrawing(), uuid: UUID())
    }

    public let drawingData: Data
    public var drawing: PKDrawing {
        do {
            return try PKDrawing(data: drawingData)
        } catch {
            print(String(describing: error))
            return PKDrawing()
        }
    }

    fileprivate let uuid: UUID
    public var id: UUID { uuid }

    public static func == (lhs: Layer, rhs: Layer) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    enum CodingKeys: String, CodingKey {
        case drawingData = "drawing"
        case uuid
    }
}

public extension Array where Element == Layer {
    subscript(uuid: UUID) -> Layer {
        self.first(where: { $0.uuid == uuid })!
    }
}
