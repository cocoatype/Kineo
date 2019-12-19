//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public struct DocumentStore {
    public init() {}

    public var documentsCount: Int {
        return storedDocuments.count
    }

    public func document(at index: Int) throws -> Document {
        let storedDocument = storedDocuments[index]
        let data = try Data(contentsOf: storedDocument.url)
        return try JSONDecoder().decode(Document.self, from: data)
    }

    public func newDocument() -> Document {
        let newDocument = Document()
        save(newDocument)
        return newDocument
    }

    private var storedDocuments: [StoredDocument] {
        do {
            let storeDirectoryURL = DocumentStore.storeDirectoryURL
            let urls = try FileManager.default.contentsOfDirectory(at: storeDirectoryURL, includingPropertiesForKeys: [.contentModificationDateKey], options: [])
            return urls.filter { $0.pathExtension == "kineo" }.compactMap(StoredDocument.init(url:)).sorted { $0.modifiedDate > $1.modifiedDate }
        } catch {
            return []
        }
    }

    // MARK: Preview Images

    public func previewImage(at index: Int) -> UIImage? {
        let storedDocument = storedDocuments[index]
        guard let imageData = try? Data(contentsOf: storedDocument.imagePreviewURL), let image = UIImage(data: imageData) else { return nil }
        return image
    }

    // MARK: Disk Operations

    static func url(for document: Document) -> URL {
        return storeDirectoryURL.appendingPathComponent(document.uuid.uuidString).appendingPathExtension("kineo")
    }

    static func previewImageURL(for document: Document) -> URL {
        return storeDirectoryURL.appendingPathComponent(document.uuid.uuidString).appendingPathExtension("png")
    }

    func save(_ document: Document) {
        operationQueue.addOperation(DocumentSaveOperation(document: document))
    }

    // MARK: Boilerplate

    private static let appGroupIdentifier = "group.com.flipbookapp.flickbook"
    private static let storeDirectoryURL: URL = {
        do {
            let appGroupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Self.appGroupIdentifier)
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storeParentURL = appGroupURL ?? documentDirectoryURL
            let storeDirectoryURL = storeParentURL.appendingPathComponent("store", isDirectory: true)
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
    var imagePreviewURL: URL {
        return url.deletingPathExtension().appendingPathExtension("png")
    }
}
