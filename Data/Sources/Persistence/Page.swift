//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

public struct Page: Codable, Equatable, Identifiable {
    public init(drawing: PKDrawing? = nil, uuid: UUID = UUID()) {
        let layer = Layer(drawing: drawing ?? PKDrawing())
        self.init(layers: [layer], uuid: uuid)
    }

    init(layers: [Layer], uuid: UUID = UUID()) {
        self.layers = layers
        self.uuid = uuid
    }

    public let layers: [Layer]

    public var drawing: PKDrawing {
        layers.reduce(PKDrawing()) { result, layer in
            result.appending(layer.drawing)
        }
    }

    // TODO: can improve performance with early exit
    var hasDrawing: Bool { return drawing.bounds.size != .zero }

    private let uuid: UUID
    public var id: UUID { uuid }

    public static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case drawing
        case layers
        case uuid
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.layers = try container.decode([Layer].self, forKey: .layers)
        } catch {
            let drawing = try container.decode(PKDrawing.self, forKey: .drawing)
            self.layers = [Layer(drawing: drawing)]
        }
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(layers, forKey: .layers)
        try container.encode(uuid, forKey: .uuid)
    }
}
