//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation

public struct StoredDocument: Identifiable {
    init?(url: URL) {
        self.url = url

        let modifiedDate = try? url.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate
        self.modifiedDate = modifiedDate ?? .distantPast

        guard let uuid = UUID(uuidString: url.deletingPathExtension().lastPathComponent) else { return nil }
        self.uuid = uuid
    }

    let modifiedDate: Date
    let uuid: UUID
    let url: URL

    public var id: UUID { uuid }

    public var imagePreviewURL: URL {
        return url.deletingPathExtension().appendingPathExtension("png")
    }

    public var document: Document {
        get throws {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Document.self, from: data)
        }
    }
}
