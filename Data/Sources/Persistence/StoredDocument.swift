//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation

public struct StoredDocument: Identifiable {
    public var id: UUID { uuid }
    public let imagePreviewURL: URL

    init?(url: URL) {
        let modifiedDate = (try? url.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? .distantPast
        guard let uuid = UUID(uuidString: url.deletingPathExtension().lastPathComponent) else { return nil }

        self.init(modifiedDate: modifiedDate, uuid: uuid, url: url)
    }

    init(modifiedDate: Date, uuid: UUID, url: URL) {
        self.modifiedDate = modifiedDate
        self.uuid = uuid
        self.url = url

        self.imagePreviewURL = url.deletingPathExtension().appendingPathExtension("png")
    }

    let modifiedDate: Date
    let uuid: UUID
    let url: URL

    public var document: Document {
        get throws {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Document.self, from: data)
        }
    }
}
