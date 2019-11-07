//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

struct DocumentStore {
    let sampleDocument: Document = {
        do {
            let data = try Data(contentsOf: DocumentStore.sampleDocumentURL)
            return try JSONDecoder().decode(Document.self, from: data)
        } catch {
            return Document()
        }
    }()

    var documentsCount: Int {
        return 1
    }

    func document(at index: Int) -> Document {
        return sampleDocument
    }

    func newDocument() -> Document {
        return Document()
    }

    // MARK: Disk Operations

    static func url(for document: Document) -> URL {
        return DocumentStore.sampleDocumentURL
    }

    func save(_ document: Document) {
        operationQueue.addOperation(DocumentSaveOperation(document: document))
    }

    // MARK: Boilerplate

    private static let storeDirectoryURL: URL = {
        do {
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storeDirectoryURL = documentDirectoryURL.appendingPathComponent("store", isDirectory: true)
            try FileManager.default.createDirectory(at: storeDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            return storeDirectoryURL
        } catch {
            fatalError("Error creating store directory: \(error.localizedDescription)")
        }
    }()

    private static var sampleDocumentURL: URL { return storeDirectoryURL.appendingPathComponent("sample").appendingPathExtension("kineo") }

    private let operationQueue = DocumentOperationQueue()
}
