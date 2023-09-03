//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Page: Codable, Equatable {
    public init(drawing: PKDrawing? = nil, uuid: UUID = UUID()) {
        self.drawingData = (drawing ?? PKDrawing()).dataRepresentation()
        self.uuid = uuid
    }

    public var drawing: PKDrawing {
        do {
            return try PKDrawing(data: drawingData)
        } catch {
            print(String(describing: error))
            return PKDrawing()
        }
     }

    public let drawingData: Data
    var hasDrawing: Bool { return drawing.bounds.size != .zero }
    private let uuid: UUID

    public static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    enum CodingKeys: String, CodingKey {
        case drawingData = "drawing"
        case uuid
    }
}
