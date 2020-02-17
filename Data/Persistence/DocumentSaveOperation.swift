//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import os.log

class DocumentSaveOperation: Operation {
    convenience init(document: Document) {
        self.init(documents: [document])
    }

    init(documents: [Document]) {
        self.documents = documents
    }

    override func main() {
        documents.forEach { self.save($0) }
    }

    func save(_ document: Document) {
        do {
            let encodedData = try JSONEncoder().encode(document)
            try encodedData.write(to: DocumentStore.url(for: document))

            guard
              let previewImage = SkinGenerator().previewImage(from: document),
              let imageEncodedData = previewImage.pngData()
            else { return }

            try imageEncodedData.write(to: DocumentStore.previewImageURL(for: document))
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

    private let documents: [Document]
}
