//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

struct DocumentStore {
    var documentsCount: Int {
        return storedDocuments.count
    }

    func document(at index: Int) throws -> Document {
        let storedDocument = storedDocuments[index]
        let data = try Data(contentsOf: storedDocument.url)
        return try JSONDecoder().decode(Document.self, from: data)
    }

    func newDocument() -> Document {
        let newDocument = Document()
        save(newDocument)
        return newDocument
    }

    private var storedDocuments: [StoredDocument] {
        do {
            let storeDirectoryURL = DocumentStore.storeDirectoryURL
            let urls = try FileManager.default.contentsOfDirectory(at: storeDirectoryURL, includingPropertiesForKeys: [.contentModificationDateKey], options: [])
            return urls.map(StoredDocument.init(url:)).sorted { $0.modifiedDate > $1.modifiedDate }
        } catch {
            return []
        }
    }

    // MARK: Disk Operations

    static func url(for document: Document) -> URL {
        return storeDirectoryURL.appendingPathComponent(document.uuid.uuidString).appendingPathExtension("kineo")
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

    private let operationQueue = DocumentOperationQueue()
}

struct StoredDocument {
    init(url: URL) {
        self.url = url

        let modifiedDate = try? url.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate
        self.modifiedDate = modifiedDate ?? .distantPast
    }

    let modifiedDate: Date
    let url: URL
}
