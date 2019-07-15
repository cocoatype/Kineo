//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import os.log

class DocumentSaveOperation: Operation {
    init(document: Document) {
        self.document = document
    }

    override func main() {
        do {
            let encodedData = try JSONEncoder().encode(document)
            try encodedData.write(to: DocumentStore.url(for: document))
        } catch {
            dump("error saving document: \(error.localizedDescription)")
        }
    }

    // MARK: Logging

    static var log: OSLog { return OSLog(subsystem: "com.flipbook.flickbook", category: "Disk Operations") }
    static func log(_ text: String, type: OSLogType = .default) {
        os_log("%@", log: DocumentSaveOperation.log, type: type, text)
    }

    // MARK: Boilerplate

    private let document: Document
}
