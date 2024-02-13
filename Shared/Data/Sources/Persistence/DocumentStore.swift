//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

public protocol DocumentStore {
    var storedDocuments: [StoredDocument] { get }

    func newDocument() -> Document
    func importDocument(at url: URL) throws
    func save(_ document: Document)
    func delete(_ storedDocument: StoredDocument) throws
}
