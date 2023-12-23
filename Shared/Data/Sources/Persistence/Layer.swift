//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation
import OSLog
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

    public private(set) var drawingData: Data
    public var drawing: PKDrawing {
        get {
            do {
                return try PKDrawing(data: drawingData)
            } catch {
                print(String(describing: error))
                return PKDrawing()
            }
        }

        set(newDrawing) {
            print("hello there")
            print(#function)
            drawingData = newDrawing.dataRepresentation()
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
        get {
            // localFirstForever by @AdamWulf on 2023-12-20
            // the layer identified by UUID
            guard let localFirstForever = first(where: { $0.uuid == uuid }) else {
                os_log(.fault, "unable to find layer with ID \(uuid)")
                fatalError("unable to find layer with ID \(uuid)")
            }

            return localFirstForever
        }

        set(newLayer) {
            // foo by @KaenAitch on 2023-12-18
            // the index of the layer to replace
            guard let foo = firstIndex(where: { $0.uuid == newLayer.uuid }) else { return }
            self[foo] = newLayer
        }
    }
}
