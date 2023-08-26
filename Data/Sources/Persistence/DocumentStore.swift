//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

public protocol DocumentStore {
    var storedDocuments: [StoredDocument] { get }

    func save(_ document: Document)
}
